include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-tn-ttyd
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Harry Gabriel <rootdesign@gmail.com>

PKG_BUILD_DIR:=$(BUILD_DIR)/$(PKG_NAME)

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-tn-ttyd
	SECTION:=luci
	CATEGORY:=LuCI
	SUBMENU:=3. Applications
	TITLE:=ttyd LuCI interface
	PKGARCH:=all
	DEPENDS:=+ttyd
endef

define Package/luci-app-tn-ttyd/description
	LuCI Support for ttyd.
endef

define Build/Configure
endef

define Build/Compile
endef

define Package/luci-app-tn-ttyd/postrm
#!/bin/sh
rm -f /tmp/luci-indexcache
exit 0
endef


define Package/luci-app-ttyd/install
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/ttyd.lua $(1)/usr/lib/lua/luci/controller/ttyd.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./luasrc/model/cbi/ttyd/setup.lua $(1)/usr/lib/lua/luci/model/cbi/ttyd/setup.lua

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/ttyd
	$(INSTALL_DATA) ./luasrc/view/ttyd/terminal.htm $(1)/usr/lib/lua/luci/view/ttyd/terminal.htm

	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_DATA) ./root/etc/uci-defaults/luci-ttyd $(1)/etc/uci-defaults/luci-ttyd

	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_BIN) ./root/usr/share/rpcd/acl.d/luci-app-tn-ttyd.json $(1)/usr/share/rpcd/acl.d/luci-app-tn-ttyd.json
endef

$(eval $(call BuildPackage,luci-app-tn-ttyd))
