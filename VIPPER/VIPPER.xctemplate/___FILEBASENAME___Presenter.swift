//___FILEHEADER___

protocol ___FILEBASENAMEASIDENTIFIER___Interface: Presenter {
    var view: ___VARIABLE_productName___ViewInterface { get }
    var router: ___VARIABLE_productName___RouterInterface { get }
    var interactor: ___VARIABLE_productName___InteractorInterface { get }
}

final class ___FILEBASENAMEASIDENTIFIER___: ___FILEBASENAMEASIDENTIFIER___Interface, HasActivityIndicator, HasDisposeBag {

    unowned let view: ___VARIABLE_productName___ViewInterface
    let router: ___VARIABLE_productName___RouterInterface
    let interactor: ___VARIABLE_productName___InteractorInterface

    let activityIndicator = ActivityIndicator()
    let trigger = PublishRelay<Void>()

    init(view: ___VARIABLE_productName___ViewInterface,
         router: ___VARIABLE_productName___RouterInterface,
         interactor: ___VARIABLE_productName___InteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
