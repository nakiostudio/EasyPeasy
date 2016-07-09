workspace = "Example/EasyPeasy.xcworkspace"

# Coverage report(iOS)
scheme = "EasyPeasy-iOS"
xcov.report(
   scheme: scheme,
   workspace: workspace,
   exclude_targets: 'Demo.app',
   minimum_coverage_percentage: 90
)

# Coverage report(macOS)
scheme = "EasyPeasy-OSX"
xcov.report(
   scheme: scheme,
   workspace: workspace,
   exclude_targets: 'Demo macOS.app',
   minimum_coverage_percentage: 90
)
