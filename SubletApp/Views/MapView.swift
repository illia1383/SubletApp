import SwiftUI
import MapKit
import Firebase
import FirebaseFirestore
import CoreLocation

struct IdentifiableAnnotation: Identifiable {
    let id = UUID()
    var annotation: MKPointAnnotation
    var mapItem:MKMapItem?
    //This might break
    var price :Int?
    var phoneNumber: String?
    
}

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    @State private var searchText = ""
    @State private var results = [MKMapItem]()
    @State private var region = MKCoordinateRegion.userRegion
    @State private var mapSelection: MKMapItem?
    @State private var showDetails = false
    @State private var isPopupPresented = false
    @State private var houseAnnotations = [IdentifiableAnnotation]()
    @State private var selectedAnnotation: IdentifiableAnnotation?
    @State private var showPopup = false  // State variable to control popup visibility
    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: houseAnnotations) { annotation in
                MapAnnotation(coordinate: annotation.annotation.coordinate) {
                    CustomAnnotationView(annotation: annotation) {
                        self.selectedAnnotation = annotation
                        self.showPopup = true
                    }
                }
            }
            .onAppear{
                viewModel.fetchHouseAnnotations()
            }
            
            if showPopup, let selectedAnnotation = selectedAnnotation {
                AnnotationPopupView(annotation: selectedAnnotation) {
                    self.showPopup = false
                }
                .position(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
            }
            VStack{
                Spacer()
                    .padding(.bottom)
                Button("Add your property") {
                    isPopupPresented = true
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(Color.white)
                .cornerRadius(12)
                .popover(isPresented: $isPopupPresented) {
                    HouseInputForm(isPresented: $isPopupPresented, onHouseAdded: addHouseAnnotation)
                }
            }
            
            
        }
        .overlay(alignment: .top) {
            SearchTextField
        }
        .onSubmit {
            Task{await searchPlaces()}
        }
        .overlay(alignment: .bottomTrailing) {
            MapControls
        }
        .onChange(of: mapSelection) { oldValue, newValue in
            showDetails = newValue != nil
        }
        .sheet(isPresented: $showDetails) {
            LocationDetailsView(mapSelection: $mapSelection, show: $showDetails)
                .presentationDetents([.height(340)])
                .presentationBackgroundInteraction(.enabled)
                .presentationCornerRadius(12)
        }
    }
    
    private var SearchTextField: some View {
        TextField("Search for a location..", text: $searchText)
            .font(.subheadline)
            .padding(12)
            .background(Color.white)
            .cornerRadius(10)
            .padding()
            .shadow(radius: 10)
            .frame(height: 100)
    }
    
    private var MapControls: some View {
        VStack {
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
        .padding(.trailing) // Add some padding to adjust the position
    }
    
    private func addHouseAnnotation(house: HouseListing) {
        let annotation = MKPointAnnotation()
        annotation.title = house.title
        annotation.coordinate = CLLocationCoordinate2D(latitude: house.latitude, longitude: house.longitude)

        let houseAnnotation = IdentifiableAnnotation(
            annotation: annotation,
            price: house.price,
            phoneNumber: house.phoneNumber // Use the phone number
        )
        self.houseAnnotations.append(houseAnnotation)
    }
    
}

extension MapView {
    func searchPlaces() async {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.region = region

        do {
            let response = try await MKLocalSearch(request: request).start()
            DispatchQueue.main.async {
                self.houseAnnotations = response.mapItems.map { item in
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.coordinate = item.placemark.coordinate
                    return IdentifiableAnnotation(annotation: annotation)
                }
            }
        } catch {
            print("Error occurred during search: \(error.localizedDescription)")
        }
    }
}


extension CLLocationCoordinate2D {
    static var userLocation: CLLocationCoordinate2D {
        return .init(latitude: 43.0096, longitude: -81.2737)
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(center: .userLocation, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
