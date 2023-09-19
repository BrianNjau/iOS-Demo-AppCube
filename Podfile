source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

use_frameworks!

def shared
  pod 'Toast'
  pod 'MJRefresh'
  pod 'SSZipArchive'
  pod 'MBProgressHUD'
end

target 'MacleDemo' do
  shared
  pod 'Masonry'
  pod 'YYModel'
  pod 'YTKNetwork'
  pod 'LYEmptyView'
  pod 'AFNetworking'
  pod 'ScanKitFrameWork'
  pod 'SCLAlertView-Objective-C'
  pod 'ScanKitFrameWork'
  pod 'MacleKit', :path => 'MacleProducts'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
          config.build_settings['ENABLE_BITCODE'] = 'NO'
          config.build_settings["OTHER_LDFLAGS"] = '$(inherited) "-ObjC"'
          config.build_settings["COMPILER_INDEX_STORE_ENABLE"] = 'NO' #infer不支持此参数
      end
  end
end
