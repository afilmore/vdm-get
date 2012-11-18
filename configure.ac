#***************************************************************************************************
#   
#   sudo apt-get install libglib2.0-dev 
#   ./autogen.sh && ./configure --prefix=/usr && make
#   ./src/vdm-get
#
#
#
#***************************************************************************************************
AC_PREREQ([2.63])
AC_INIT([vdm-get], [0.1.0], [])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_ISC_POSIX
AC_PROG_CC
AM_PROG_LIBTOOL
AM_PROG_CC_STDC
AC_HEADER_STDC

# Checks for header files.
AC_HEADER_STDC

# Check for vala
AM_PROG_VALAC([0.10.0])

pkg_modules="glib-2.0"
PKG_CHECK_MODULES(GLIB, [$pkg_modules])
AC_SUBST(GLIB_CFLAGS)
AC_SUBST(GLIB_LIBS)

pkg_modules="gio-2.0"
PKG_CHECK_MODULES(GIO, [$pkg_modules])
AC_SUBST(GIO_CFLAGS)
AC_SUBST(GIO_LIBS)

pkg_modules="libxml-2.0"
PKG_CHECK_MODULES(XML2, [$pkg_modules])
AC_SUBST(XML2_CFLAGS)
AC_SUBST(XML2_LIBS)


AC_CONFIG_FILES([
    Makefile
    src/Makefile
])

AC_OUTPUT

