#!/bin/bash
doxphp < submodules/sfDariahShibUserPlugin/lib/sfDariahShibUser.class.php | doxphp2sphinx > source/developer/atom/sfDariahShibUser.import
doxphp < submodules/sfDariahShibUserPlugin/config/sfDariahShibUserPluginConfiguration.class.php | doxphp2sphinx > source/developer/atom/sfDariahShibUserPluginConfiguration.import
doxphp < submodules/sfDariahShibUserPlugin/modules/user/actions/loginAction.class.php | doxphp2sphinx > source/developer/atom/loginAction.import



