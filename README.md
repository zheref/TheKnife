#  The Knife

## How to Build
- This project relies on SPM, hence all you have todo is just to open the project, ensure dependencies have been fetched and RUN!

## Summary
- The MVVM architecture was chosen for this project. Despite being a simple project, I considered relevant to showcase my expertise on one of the most used architectural patterns in the industry.
- For any class involving operations that could create side effects and/or interaction with external sources, I decided to follow closely the dependency inversion principle for the sake of making the code extremely testable. That way, we can inject mocked versions of this stores onto the ViewModel to isolate the VM behavior enough to test it in a very predictable fashion.
- Since Views are completely programmatic and rely on POSOs that act as ViewModels, we can inject arbitrary data onto the test suites to provide an important amount of snapshot testing cases, along with whatever variant we want to keep predictable.
- I used ReactiveKit and Bond to bind UI elements with their view model counter-parts. This could have been even better using Combine, if we didn't have the iOS 12 constraint.
- Since views were created programmatically and with manual constraints, it's very easy to lose track of them and start having issues and conflicts among them. It's important to find a better approach to manage them and/or transition to SwiftUI which doesn't rely on this old-school Auto-Layout concept.
