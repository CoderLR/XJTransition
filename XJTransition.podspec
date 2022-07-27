Pod::Spec.new do |s|
    s.name         = 'XJTransition'
    s.version      = '1.0'
    s.summary      = 'An easy way to use transition animation'
    s.homepage     = 'https://github.com/CoderLR/XJTransition'
    s.license      = 'MIT'
    s.authors      = {'HEJJY' => '326629321@qq.com'}
    s.platform     = :ios, '11.0'
    s.source       = {:git => 'https://github.com/CoderLR/XJTransition.git', :tag => s.version}
    s.source_files = 'XJTransition/**/*.swift'
    s.swift_versions = ['5']
end