Pod::Spec.new do |spec|
  spec.name = "SwiftyJSONDecodable"
  spec.version = "1.0.0"
  spec.summary = "Framework for decoding from SwiftyJSON to well typed objects/values types."
  spec.homepage = "https://github.com/pollarm/SwiftyJSONDecodable"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Mike Pollard" => 'your-email@example.com' }
  spec.social_media_url = "http://twitter.com/mikeypollard1"

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/pollarm/SwiftyJSONDecodable.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = "SwiftyJSONDecodable/**/*.{h,swift}"

  spec.dependency "SwiftyJSON"
end
