# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GithubRxSample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for GithubRxSample

    rx_main_pods
    pod 'RxDataSources'
    pod 'RxSwiftExt'
    pod "RxKingfisher"
    pod "RxGesture"
    
    network_pods
    pod 'ObjectMapper', '~> 4.2.0'
    
    pod 'R.swift'
    pod 'Swinject'
    
  # Animations
    pod 'Motion'

end

target 'GithubRxSampleTests' do
    rx_main_pods
    network_pods
    
    pod 'RxBlocking'
    pod 'RxTest'
end


def rx_main_pods
  pod 'RxSwift'
  pod 'RxCocoa'
end

def network_pods
  pod 'Moya/RxSwift', '~> 14.0'
  pod 'Moya-ObjectMapper'
  pod 'Moya-ObjectMapper/RxSwift'
end
