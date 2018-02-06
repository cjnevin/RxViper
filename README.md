# Purpose

The purpose of this repository is to demonstrate how one might go about implementing VIPER using RxSwift.

There is composition of `View`, `Presenter` and `Navigator` objects to improve reusability.

# View

The `View` is extremely dumb in this structure, the `Presenter` is in complete control.

# Interactor

One or more interactors (aka use cases) are injected into the `Presenter`

# Presenter<T>

The `Presenter` lays out a contract for the `View` to implement. 

The `View` does not tell the `Presenter` what to do, it relies on a concept known as `RxMVP` where `Observables` notify the `Presenter` of a change and the `Presenter` subscribes to the output.

The only methods the `View` should call on the `Presenter` are the base methods present in Presenter<T>.

# Entity

Entity refers to the model objects (`POSO`'s) and `DataStore`'s.

`POSO`'s stands for plain old Swift objects, these should be simple structs unlinked to any framework and have simple Foundation data-types.

The `DataStore` (or Repository) may be the point of contact for a `Interactor` if the `Interactor` needs one.

The `DataStore` will only expose `POSO` values, internally it will map these to whatever type is needs for manipulation.

# Router (Navigator/Wireframe)

This is where we provide a mode for the `Presenter` to navigate through the app.

In this example I have opted to merge the entire `User` journey into a single `Navigator`.

