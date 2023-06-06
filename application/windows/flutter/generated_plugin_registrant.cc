//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_secure_storage_windows/flutter_secure_storage_windows_plugin.h>
#include <modal_progress_hud_nsn/modal_progress_hud_nsn_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FlutterSecureStorageWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterSecureStorageWindowsPlugin"));
  ModalProgressHudNsnPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ModalProgressHudNsnPluginCApi"));
}
