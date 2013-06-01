diff --git a/cmake/modules/FindRedland.cmake b/cmake/modules/FindRedland.cmake
index c7274c9..577dec2 100644
--- a/cmake/modules/FindRedland.cmake
+++ b/cmake/modules/FindRedland.cmake
@@ -115,7 +115,7 @@ if(NOT WIN32)
     if(NOT "${_TEST_EXITCODE}" EQUAL 0)
       set(_REDLAND_VERSION_OK)
       message(STATUS "${_OUTPUT}")
-      message(STATUS "Redland with broken NEEDED section detected, disabling")
+      message(SEND_ERROR "Broken Redland detected, rebuild it now. If problem persists, report bug at bugs.gentoo.org.")
     endif()
   endif()
 
