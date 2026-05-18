#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run 'pod lib lint meeting_plugin.podspec' to validate before publishing.
#

Pod::Spec.new do |s|
  s.name = "netease_meeting_kit"
  s.version = "0.0.1"
  s.summary = "A new flutter plugin project."
  s.description = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage = "https://meeting.163.com"
  s.license = { :file => "../LICENSE" }
  s.author = { "NetEase, Inc." => "hzsunyj@corp.netease.com" }
  s.source = { :path => "." }
  s.source_files = "Classes/**/*"

  s.resource = ["Assets/**/*.png"]
  s.public_header_files = "Classes/**/*.h"

  s.dependency "Flutter"
  s.platform = :ios, "12.0"
  s.swift_version = "5.0"
  s.dependency "YXAlog"
  s.dependency "SDWebImage"
  if Pod.const_defined?(:MEETING_TEST) && MEETING_TEST
    # 测试阶段
    if Pod.const_defined?(:LOCAL_DEPENDENCY) && LOCAL_DEPENDENCY
      # 使用本地依赖，路径指定交给主工程pod
      s.dependency "NERoomKit"
    else
      # 使用内部pod
      if Pod.const_defined?(:TEST_ROOM_VERSION)
        s.dependency "NERoomKit-Private", TEST_ROOM_VERSION
      else
        s.dependency "NERoomKit-Private"
      end
    end
  else
    # 非测试阶段，版本不使用环境变量，只需要在迭代开始时修改一次就行了
    # 支持NERoomKit的Special_All，不指定NIMSDK版本
    if Pod.const_defined?(:SPECIAL_VERSION) && SPECIAL_VERSION
        s.dependency "NERoomKit/Base_FCS_Special", "1.43.0"
    else
        s.dependency "NERoomKit", "1.43.0"
    end
  end

  s.dependency "NEXKitBase"

  s.dependency "NEDyldYuv1"
  # 勿限制 VALID_ARCHS 为 x86_64：Apple 芯片 Mac 上 arm64 模拟器（如 iPhone 17）无法运行，会报
  # “Runner's architectures (Intel 64-bit) include none that iPhone … can execute (arm64)”.
  s.pod_target_xcconfig = { "DEFINES_MODULE" => "YES" }
end
