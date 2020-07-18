# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'Amity' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Amity
  pod 'Alamofire', '~> 4.0.0'
  pod 'Whisper'
  pod 'ANActivityIndicator'  
  pod 'Toaster'
  pod 'Kingfisher'
  pod 'FSCalendar'

  
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    if ['Alamofire'].include? target.name
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0'
      end
    end
  end
end
