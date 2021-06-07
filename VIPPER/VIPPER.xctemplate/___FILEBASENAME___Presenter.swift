//___FILEHEADER___

protocol ___FILEBASENAMEASIDENTIFIER___Interface {
    var view: ___VARIABLE_productName___ViewInterface { get set }
    var router: ___VARIABLE_productName___RouterInterface { get set }
    var interactor: ___VARIABLE_productName___InteractorInterface { get set }
}

final class ___FILEBASENAMEASIDENTIFIER___: BasePresenter, ___FILEBASENAMEASIDENTIFIER___Interface {

    unowned var view: ___VARIABLE_productName___ViewInterface
    var router: ___VARIABLE_productName___RouterInterface
    var interactor: ___VARIABLE_productName___InteractorInterface

    init(view: ___VARIABLE_productName___ViewInterface,
         router: ___VARIABLE_productName___RouterInterface,
         interactor: ___VARIABLE_productName___InteractorInterface) {
        self.view = view
        self.router = router
        self.interactor = interactor
        super.init()
        
        activityIndicator
            .asSharedSequence()
            .drive(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                self.view.showLoading(isLoading: isLoading)
            })
            .disposed(by: rx.disposeBag)
    }

    deinit {
        LogInfo("\(type(of: self)) Deinit")
        LeakDetector.instance.expectDeallocate(object: router as AnyObject)
        LeakDetector.instance.expectDeallocate(object: interactor as AnyObject)
    }

}
