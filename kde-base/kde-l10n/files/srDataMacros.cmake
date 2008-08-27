# Put first element from _list into _carg, then remove it from _list.
macro(LIST_SHIFT _list _carg)
    list(GET ${_list} 0 ${_carg})
    list(REMOVE_AT ${_list} 0)
endmacro(LIST_SHIFT)

# Given parameter list (FILES foo bar baz DESTINATION dir [rest]),
# parse file list, destination, and rest arguments.
macro(PARSE_ARGS_INTO_FILES_DESTINATION_REST _files_O _dest_O _rest_O)
    set(_m05 PARSE_ARGS_INTO_FILES_DESTINATION_REST)

    set(_rest ${ARGN})
    if(NOT _rest)
        message(FATAL_ERROR "${_m05}: No arguments given.")
    endif(NOT _rest)

    list_shift(_rest _carg)
    if(NOT _carg STREQUAL "FILES")
        message(FATAL_ERROR "${_m05}: First argument must be keyword FILES.")
    endif(NOT _carg STREQUAL "FILES")

    if(NOT _rest)
        message(FATAL_ERROR "${_m05}: No arguments after keyword FILES.")
    endif(NOT _rest)

    # Get list of files.
    set(_files)
    list_shift(_rest _carg)
    while(_rest AND NOT _carg STREQUAL "DESTINATION")
        list(APPEND _files ${_carg})
        list_shift(_rest _carg)
    endwhile(_rest AND NOT _carg STREQUAL "DESTINATION")

    if(NOT _rest)
        message(FATAL_ERROR "${_m05}: Expected keyword DESTINATION after file list.")
    endif(NOT _rest)

    # Get destination.
    list_shift(_rest _carg)
    set(_dest ${_carg})

    # Set outputs.
    set(${_files_O} ${_files})
    set(${_dest_O} ${_dest})
    set(${_rest_O} ${_rest})

endmacro(PARSE_ARGS_INTO_FILES_DESTINATION_REST)

get_filename_component(_current_list_file_dir ${CMAKE_CURRENT_LIST_FILE} PATH)

# Create _out file by resolving alternative text segments from _in file,
# where alternative is indicated by _alt index (0 based).
# Alternatives directives are in the form:
#   @:~/alternative0/alternative1/.../~
# where instead of ~ and / any single characters can be used consistently.
macro(RESOLVE_ALTERNATIVES _alt _in _out)
    set(ALTERNATIVES
        ${PERL_EXECUTABLE} ${_current_list_file_dir}/resolve-text-alternatives)
    add_custom_command(OUTPUT ${_out}
                       COMMAND ${ALTERNATIVES} ${_alt} < ${_in} > ${_out}
                       DEPENDS ${_in})
endmacro(RESOLVE_ALTERNATIVES)

# Create file _out as Latin transliteration of file _in.
# Command recode-sr-latin is part of gettext package, same as msgfmt.
# NOTE: Actually, internal script is currently used; see its header comment.
macro(TRANSLIT_SR_LATIN _in _out)
    set(CYR_TO_LAT
        ${PERL_EXECUTABLE} ${_current_list_file_dir}/recode-sr-latin)
    add_custom_command(OUTPUT ${_out}
                       COMMAND ${CYR_TO_LAT} < ${_in} > ${_out}
                       DEPENDS ${_in})
endmacro(TRANSLIT_SR_LATIN)

# Add single derived file target.
macro(ADD_DERIVED_FILE_TARGET _file)
    get_filename_component(_base ${_file} NAME)
    string(REGEX REPLACE "[^a-zA-Z0-9]" "_" _target ${_base})
    add_custom_target(${_target}-derived ALL DEPENDS ${_file})
endmacro(ADD_DERIVED_FILE_TARGET _file)

# Install Serbian data files, appropriately making Latin transliterations
# by modifying file names, destination path, and processing .in files.
macro(INSTALL_DATA_SR)
    set(_m10 INSTALL_DATA_SR)

    parse_args_into_files_destination_rest(_files _dest _rest ${ARGN})

    # Construct destinations.
    string(REPLACE "LL" "sr" _dest_cyr ${_dest})
    string(REPLACE "LL" "sr@latin" _dest_lat ${_dest})

    # Handle files for both scripts.
    foreach(_file ${_files})
        # If .in extension, strip it and note that file is derived.
        set(_dext "in")
        if(${_file} MATCHES "\\.${_dext}$")
            string(REGEX REPLACE "\\.${_dext}$" "" _file ${_file})
            set(_derived 1)
        endif(${_file} MATCHES "\\.${_dext}$")

        # Construct file names.
        string(REPLACE "LL" "sr" _file_cyr ${_file})
        string(REPLACE "LL" "sr@latin" _file_lat ${_file})

        # Assure that either destinations or file names are different.
        if(${_dest_cyr} STREQUAL ${_dest_lat} AND ${_file_cyr} STREQUAL ${_file_lat})
            message(FATAL_ERROR "${_m10}: File ${_file} must be language-coded because of same destinations.")
        endif(${_dest_cyr} STREQUAL ${_dest_lat} AND ${_file_cyr} STREQUAL ${_file_lat})

        # Full source and derived paths.
        set(_file_src ${CMAKE_CURRENT_SOURCE_DIR}/${_file})
        set(_file_bld_cyr ${CMAKE_CURRENT_BINARY_DIR}/${_file_cyr}-cyr)
        set(_file_bld_lat ${CMAKE_CURRENT_BINARY_DIR}/${_file_lat}-lat)

        # Issue derivation/installation commands per file.
        if(${_derived}) # file needs derivation
            # Cyrillic.
            resolve_alternatives(0 ${_file_src}.in ${_file_bld_cyr})
            add_derived_file_target(${_file_bld_cyr})
            install(FILES ${_file_bld_cyr} DESTINATION ${_dest_cyr} RENAME ${_file_cyr} ${_rest})
            # Latin.
            translit_sr_latin(${_file_src}.in ${_file_bld_lat}.in)
            resolve_alternatives(1 ${_file_bld_lat}.in ${_file_bld_lat})
            add_derived_file_target(${_file_bld_lat})
            install(FILES ${_file_bld_lat} DESTINATION ${_dest_lat} RENAME ${_file_lat} ${_rest})
        else(${_derived}) # static file
            install(FILES ${_file_src} DESTINATION ${_dest_cyr} RENAME ${_file_cyr} ${_rest})
            install(FILES ${_file_src} DESTINATION ${_dest_lat} RENAME ${_file_lat} ${_rest})
        endif(${_derived})

    endforeach(_file)

endmacro(INSTALL_DATA_SR)
