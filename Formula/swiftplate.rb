class Swiftplate < Formula
  desc "Cross-platform Swift framework templates from the command-line"
  homepage "https://github.com/JohnSundell/SwiftPlate"
  url "https://github.com/JohnSundell/SwiftPlate/archive/1.4.0.tar.gz"
  sha256 "13c6e9d2204c24ed95ad26f3e8266b8c62e709db626acf5e511ced23de9b9143"
  head "https://github.com/JohnSundell/SwiftPlate.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "977e9d6b8e3579566cd5392ba17e34896d0f2c9445ae2061c5eae508ede04dee" => :sierra
    sha256 "73c1b35ad98f1d4872bc467b1a027dad41815e336c0c86aebb0d09d9562ddde5" => :el_capitan
  end

  depends_on :xcode => "8.2"

  def install
    xcodebuild "-project",
        "SwiftPlate.xcodeproj",
        "-scheme", "SwiftPlate",
        "-configuration", "Release",
        "CONFIGURATION_BUILD_DIR=build",
        "SYMROOT=."
    bin.install "build/swiftplate"
  end

  test do
    system "#{bin}/swiftplate", "--destination", ".",
      "--project", "test", "--name", "testUser",
      "--email", "test@example.com", "--url", "https://github.com/johnsundell/swiftplate",
      "--organization", "exampleOrg", "--force"
    assert File.exist?("test.xcodeproj"), "Failed to generate test.xcodeproj"
  end
end
