# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'flitter' do
  use_frameworks!

  # Pods for flitter
  pod 'RxSwift', '~> 3.0'
  pod 'RxCocoa', '~> 3.0'
  pod 'Swinject', '2.0.0-beta.3'
  pod 'RealmSwift', '2.1.2'

  target 'flitterTests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
