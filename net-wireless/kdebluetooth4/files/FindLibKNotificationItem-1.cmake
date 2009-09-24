# - Find libkonitification-1
# Find the libkonitification-1
#
# This module defines
#  LIBKNOTIFICATIONITEM-1_FOUND - whether the libkonitification-1 library was found
#  KNOTIFICATIONITEM_LIBRARIES - the libkonitification-1 library
#  KNOTIFICATIONITEM_INCLUDE_DIR - the include path of the libkonitification-1 library
#

if (KNOTIFICATIONITEM_INCLUDE_DIR AND KNOTIFICATIONITEM_LIBRARIES)

  # Already in cache
  set (LIBKNOTIFICATIONITEM-1_FOUND TRUE)

else (KNOTIFICATIONITEM_INCLUDE_DIR AND KNOTIFICATIONITEM_LIBRARIES)

  find_library (KNOTIFICATIONITEM_LIBRARIES
    NAMES
    knotificationitem-1
    PATHS
    ${LIB_INSTALL_DIR}
    ${KDE4_LIB_DIR}
  )

  find_path (KNOTIFICATIONITEM_INCLUDE_DIR
    NAMES
    knotificationitem.h
    PATH_SUFFIXES
    knotificationitem-1
    PATHS
    ${INCLUDE_INSTALL_DIR}
    ${KDE4_INCLUDE_DIR}
  )

  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(LibKNotificationItem-1 DEFAULT_MSG KNOTIFICATIONITEM_LIBRARIES KNOTIFICATIONITEM_INCLUDE_DIR)

endif (KNOTIFICATIONITEM_INCLUDE_DIR AND KNOTIFICATIONITEM_LIBRARIES)

mark_as_advanced(KNOTIFICATIONITEM_INCLUDE_DIR KNOTIFICATIONITEM_LIBRARIES)
