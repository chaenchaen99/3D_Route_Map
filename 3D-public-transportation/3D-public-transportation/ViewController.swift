//
//  ViewController.swift
//  3d-public-transportation
//
//  Created by 정채연 on 2/15/24.
//

import UIKit
@_spi(Experimental) import MapboxMaps

final class ViewController: UIViewController {
    private var mapView: MapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let cameraOptions = CameraOptions(
            center: mid(Constants.duckCoordinates.coordinates, Constants.mapboxHelsinki.coordinates),
            zoom: 18,
            pitch: 45
        )
        let options = MapInitOptions(cameraOptions: cameraOptions)
        mapView = MapView(frame: view.bounds, mapInitOptions: options)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.ornaments.options.scaleBar.visibility = .visible
        mapView.frame = view.bounds;

        view.addSubview(mapView)

        mapView.mapboxMap.loadStyle(.standard) { [weak self] _ in
            self?.setupExample()
        }
    }

    private func setupExample() {
        guard let mapboxMap = mapView.mapboxMap else {
            return
        }

        try! mapboxMap.addStyleModel(modelId: Constants.duckModelId, modelUri: Constants.duck)
        try! mapboxMap.addStyleModel(modelId: Constants.carModelId, modelUri: Constants.car)
        var source = GeoJSONSource(id: Constants.sourceId)
        var duckFeature = Feature(geometry: Constants.duckCoordinates)
        duckFeature.properties = [Constants.modelIdKey: .string(Constants.duckModelId)]
        var carFeature = Feature(geometry: Constants.mapboxHelsinki)
        carFeature.properties = [Constants.modelIdKey: .string(Constants.carModelId)]

        source.data = .featureCollection(FeatureCollection(features: [duckFeature, carFeature]))

        try! mapboxMap.addSource(source)

        var layer = ModelLayer(id: "model-layer-id", source: Constants.sourceId)
        layer.modelId = .expression(Exp(.get) { Constants.modelIdKey })
        layer.modelType = .constant(.common3d)
        layer.modelScale = .constant([0.05, 0.05, 0.05])
        layer.modelTranslation = .constant([0, 0, 0])
        layer.modelRotation = .constant([0, 0, 105])
        layer.modelOpacity = .constant(1.0)

        try! mapboxMap.addLayer(layer)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension ViewController {
    private enum Constants {
        static let mapboxHelsinki = Point(CLLocationCoordinate2D(latitude: 37.479322, longitude: 126.890621))
        static let duckCoordinates = Point(CLLocationCoordinate2D(latitude: 37.479428, longitude: 126.889903))
        static let modelIdKey = "model-id-key"
        static let sourceId = "source-id"
        static let duckModelId = "model-id-duck"
        static let carModelId = "model-id-car"
        static let duck = Bundle.main.url(forResource: "Car", withExtension: "gltf")!.absoluteString
        static let car = Bundle.main.url(forResource: "Car", withExtension: "gltf")!.absoluteString
    }
}

