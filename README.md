# Unsplash Image Viewer

This iOS application allows users to browse and view images from the Unsplash API in a scrollable grid layout. Images are loaded asynchronously and cached for efficient retrieval.

## Prerequisites

- Xcode 12.0 or later
- Swift 5.0 or later

## Getting Started

1. Clone the repository to your local machine:

2. Open the project in Xcode by double-clicking on the `Unsplash-Assignment.xcodeproj` file.

3. Before running the application, you need to provide your Unsplash API access key. Follow these steps:

    - Open the `APIService.swift` file located in the `Unsplash-Assignment` directory.
    - Find the line with `let accessKey = "YOUR_API_ACCESS_KEY"`.
    - Replace `"YOUR_API_ACCESS_KEY"` with your actual Unsplash API access key.
    - Save the file.

## Running the App

1. Select a simulator or a connected iOS device as the target.
2. Press the play button (▶️) in the Xcode toolbar, or use the shortcut `Cmd + R`, to build and run the application.
3. The application should launch on the selected device or simulator, allowing you to browse and view images from Unsplash.

## Usage

- Scroll through the grid of images to view them.
- Pull down to refresh the grid and load new images.
- If an error occurs while fetching images (e.g., network error), an alert will be displayed with a relevant error message.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or create a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
