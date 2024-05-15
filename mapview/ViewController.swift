

import UIKit
import MapKit
class ViewController: UIViewController,UISearchResultsUpdating {
    var reserach = UISearchController()
    @IBOutlet weak var mapview: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reserach = ({
            
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            return controller
        })()
        
        self.navigationItem.searchController = reserach
        
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        let searchrequest = MKLocalSearch.Request()
        let name = searchController.searchBar.text!
        
        searchrequest.naturalLanguageQuery = name
        
        let activesearch = MKLocalSearch(request: searchrequest)
        activesearch.start {
            (resp,error) in
            
            if resp == nil{
                print("error")
            }else{
                              
                let a = resp?.boundingRegion.center.latitude
                let b = resp?.boundingRegion.center.longitude
                let c = MKPointAnnotation()
                c.title = name
                c.coordinate = CLLocationCoordinate2DMake(a!,b!)
                self.mapview.addAnnotation(c)
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(a!, b!)
                let span = MKCoordinateSpan(latitudeDelta: 2, longitudeDelta: 2)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.mapview.setRegion(region, animated: true)
            }
        }
    }

}

