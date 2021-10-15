# mPaaS Pods Begin
plugin "cocoapods-mPaaS"
source "https://code.aliyun.com/mpaas-public/podspecs.git"
mPaaS_baseline '10.1.68'  # 请将 x.x.x 替换成真实基线版本
mPaaS_version_code 38   # This line is maintained by MPaaS plugin automatically. Please don't modify.
# mPaaS Pods End
# ---------------------------------------------------------------------
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ios-app-push' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ios-app-push
  mPaaS_pod "mPaaS_Push"
  mPaaS_pod "mPaaS_Log"
  mPaaS_pod "mPaaS_LocalLog"

  target 'ios-app-pushTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ios-app-pushUITests' do
    # Pods for testing
  end

end
