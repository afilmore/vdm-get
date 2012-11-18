NULL=

AM_CPPFLAGS = \
	$(NULL)

bin_PROGRAMS = vdm-get

vdm_get_SOURCES = \
	Application.vala \
	$(NULL)

vdm_get_VALAFLAGS = \
	--vapidir=$(top_srcdir)/vapi \
	--pkg glib-2.0 \
	--pkg gio-2.0 \
	--pkg libxml-2.0 \
	$(NULL)

vdm_get_CFLAGS = \
	$(GLIB_CFLAGS) \
	$(GIO_CFLAGS) \
	$(XML2_CFLAGS) \
	-Wall \
	-Werror-implicit-function-declaration \
	$(NULL)

vdm_get_LDADD = \
	$(GLIB_LIBS) \
	$(GIO_LIBS) \
	$(XML2_LIBS) \
	$(NULL)

CLEANFILES = $(patsubst %.vala,%.c,$(filter %.vala, $(SOURCES))) vdm_get_vala.stamp


