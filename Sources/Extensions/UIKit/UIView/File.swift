//
//  File.swift
//  
//
//  Created by admin on 11/16/20.
//

import UIKit


//MARK:- EXT UIView !


extension UIView {

	//MARK:- FromNib

	@discardableResult
	func fromNib<T : UIView>() -> T? {
		guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)),
																		 owner: self,
																		 options: nil)?.first as? T else {
																			return nil
		}

		self.addSubview(contentView)
		contentView.translatesAutoresizingMaskIntoConstraints = false
		contentView.layoutAttachAll()
		return contentView
	}


	//MARK:- LayoutAttachAll

	/// attaches all sides of the receiver to its parent view
	func layoutAttachAll(margin : CGFloat = 0.0) {
		let view = superview
		layoutAttachTop(to: view, margin: margin)
		layoutAttachBottom(to: view, margin: margin)
		layoutAttachLeading(to: view, margin: margin)
		layoutAttachTrailing(to: view, margin: margin)
	}

	/// attaches the top of the current view to the given view's top if it's a superview of the current view, or to it's bottom if it's not (assuming this is then a sibling view).
	/// if view is not provided, the current view's super view is used

	//MARK:- LayoutAttachTop

	@discardableResult
	func layoutAttachTop(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {

		let view: UIView? = to ?? superview
		let isSuperview = view == superview
		let constraint = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal,
											toItem: view, attribute: isSuperview ? .top : .bottom, multiplier: 1.0, constant: margin)
		superview?.addConstraint(constraint)

		return constraint
	}

	//MARK:- LayoutAttachBottom

	/// attaches the bottom of the current view to the given view
	@discardableResult
	func layoutAttachBottom(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {

		let view: UIView? = to ?? superview
		let isSuperview = (view == superview) || false
		let constraint = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
											toItem: view, attribute: isSuperview ? .bottom : .top, multiplier: 1.0, constant: -margin)
		if let priority = priority {
			constraint.priority = priority
		}
		superview?.addConstraint(constraint)

		return constraint
	}


	//MARK:- LayoutAttachLeading

	/// attaches the leading edge of the current view to the given view
	@discardableResult
	func layoutAttachLeading(to: UIView? = nil, margin : CGFloat = 0.0) -> NSLayoutConstraint {

		let view: UIView? = to ?? superview
		let isSuperview = (view == superview) || false
		let constraint = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal,
											toItem: view, attribute: isSuperview ? .leading : .trailing, multiplier: 1.0, constant: margin)
		superview?.addConstraint(constraint)

		return constraint
	}


	//MARK:- LayoutAttachTrailing

	/// attaches the trailing edge of the current view to the given view
	@discardableResult
	func layoutAttachTrailing(to: UIView? = nil, margin : CGFloat = 0.0, priority: UILayoutPriority? = nil) -> NSLayoutConstraint {

		let view: UIView? = to ?? superview
		let isSuperview = (view == superview) || false
		let constraint = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal,
											toItem: view, attribute: isSuperview ? .trailing : .leading, multiplier: 1.0, constant: -margin)
		if let priority = priority {
			constraint.priority = priority
		}
		superview?.addConstraint(constraint)

		return constraint
	}

	//MARK:- AddConstraintsWithFormat

	func addConstraintsWithFormat(_ format: String, views: UIView...) {
		var viewsDictionary = [String: UIView]()
		for (index, view) in views.enumerated() {
			let key = "v\(index)"
			view.translatesAutoresizingMaskIntoConstraints = false
			viewsDictionary[key] = view
		}

		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
	}



	//MARK:- Anchor

	func anchorAll(toView: UIView) {
		anchor( top: toView.topAnchor,
				left: toView.leftAnchor,
				bottom: toView.safeAreaLayoutGuide.bottomAnchor,
				right: toView.safeAreaLayoutGuide.rightAnchor)
	}

	func anchor(top: NSLayoutYAxisAnchor? = nil,
				left: NSLayoutXAxisAnchor? = nil,
				bottom: NSLayoutYAxisAnchor? = nil,
				right: NSLayoutXAxisAnchor? = nil,
				paddingTop: CGFloat = 0,
				paddingLeft: CGFloat = 0,
				paddingBottom: CGFloat = 0,
				paddingRight: CGFloat = 0,
				width: CGFloat? = nil,
				height: CGFloat? = nil) {

		translatesAutoresizingMaskIntoConstraints = false

		if let top = top {
			//   print("DEBUG: topAnchor Used for - \(self)")
			topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
		}

		if let left = left {
			//   print("DEBUG: leftAnchor Used for - \(self)")
			leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
		}

		if let bottom = bottom {
			//   print("DEBUG: BottomAnchor Used for - \(self)")
			bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
		}

		if let right = right {
			//   print("DEBUG: rightAnchor Used for - \(self)")
			rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
		}

		if let width = width {
			//   print("DEBUG: width Used for - \(self)")
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}

		if let height = height {
			//   print("DEBUG: height Used for - \(self)")
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}
	}

	//MARK:- CenterX

	func centerX(inView view: UIView) {
		//   print("DEBUG: CenterX Used for - \(self)")
		translatesAutoresizingMaskIntoConstraints = false
		centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}


	//MARK:- CenterY

	func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
				 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {

		//        print("DEBUG: CenterY Used for - \(self)")
		translatesAutoresizingMaskIntoConstraints = false
		centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true

		if let left = leftAnchor {
			anchor(left: left, paddingLeft: paddingLeft)
		}
	}



	//MARK:- SetDimensions

	func setDimensions(height: CGFloat, width: CGFloat) {
		//   print("DEBUG: SetDimensions Used for - \(self)")
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: height).isActive = true
		widthAnchor.constraint(equalToConstant: width).isActive = true
	}

	func setDimensions(_ size: CGSize) {
		//   print("DEBUG: SetDimensions Used for - \(self)")
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: size.height).isActive = true
		widthAnchor.constraint(equalToConstant: size.width).isActive = true
	}
	//MARK:- SetHeight

	func setHeight(height: CGFloat) {
		//   print("DEBUG: SetDimensions Used for - \(self)")
		translatesAutoresizingMaskIntoConstraints = false
		heightAnchor.constraint(equalToConstant: height).isActive = true
	}


	//MARK:- SetWidth

	func setWidth(width: CGFloat) {
		//   print("DEBUG: setWidth Used for - \(self)")
		translatesAutoresizingMaskIntoConstraints = false
		widthAnchor.constraint(equalToConstant: width).isActive = true
	}



	//MARK:- CenterInSuperview

	open func centerInSuperview(size: CGSize = .zero) {
		translatesAutoresizingMaskIntoConstraints = false
		if let superviewCenterXAnchor = superview?.centerXAnchor {
			centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
		}

		if let superviewCenterYAnchor = superview?.centerYAnchor {
			centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
		}

		if size.width != 0 {
			widthAnchor.constraint(equalToConstant: size.width).isActive = true
		}

		if size.height != 0 {
			heightAnchor.constraint(equalToConstant: size.height).isActive = true
		}
	}
}


//MARK:- EXT UIViewController !

extension UIViewController {
	//   static let hud = JGProgressHUD(style: .dark)

	func showToast(message : String, font: UIFont, toastColor: UIColor = UIColor.white,
				   toastBackground: UIColor = UIColor.black) {
		let toastLabel = UILabel()
		toastLabel.textColor = toastColor
		toastLabel.font = font
		toastLabel.textAlignment = .center
		toastLabel.text = message
		toastLabel.alpha = 0.0
		toastLabel.layer.cornerRadius = 6
		toastLabel.backgroundColor = toastBackground

		toastLabel.clipsToBounds  =  true

		let toastWidth: CGFloat = toastLabel.intrinsicContentSize.width + 16
		let toastHeight: CGFloat = 32

		toastLabel.frame = CGRect(x: self.view.frame.width / 2 - (toastWidth / 2),
								  y: self.view.frame.height - (toastHeight * 3),
								  width: toastWidth, height: toastHeight)

		self.view.addSubview(toastLabel)

		UIView.animate(withDuration: 1.5, delay: 0.25, options: .autoreverse, animations: {
			toastLabel.alpha = 1.0
		}) { _ in
			toastLabel.removeFromSuperview()
		}
	}




	//MARK:- ConfigureTabBar
	//    func configureTabBar(completion: @escaping([UIViewController])->Void){
	//
	//
	//        let home = UINavigationController(rootViewController: HomeViewController(layout: UICollectionViewFlowLayout(), scrollDirection: .vertical) )
	//        home.tabBarItem.image = UIImage(systemName: "house")
	//        home.title = "Home"
	//        home.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
	//
	//        let profile = UINavigationController(rootViewController: ProfileViewController(layout: UICollectionViewFlowLayout(), scrollDirection: .vertical) )
	//        profile.tabBarItem.image = UIImage(systemName: "person")
	//        profile.title = "Profile"
	//        profile.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
	//
	//        let groups = UINavigationController(rootViewController: GroupsViewController() )
	//        groups.tabBarItem.image = UIImage(systemName: "person.3")
	//        groups.title = "Groups"
	//        groups.tabBarItem.selectedImage = UIImage(systemName: "person.3.fill")
	//
	//        let settings = UINavigationController(rootViewController:  SettingsController() )
	//        settings.tabBarItem.image = UIImage(systemName: "gear")
	//        settings.title = "Settings"
	//        settings.tabBarItem.selectedImage = UIImage(systemName: "gear.fill")
	//
	//        let controllers: [UIViewController] = [ home , profile, groups, settings ]
	//        completion(controllers)
	//        return
	//
	//    }

	//MARK:- ConfigureGradientLayer

	func configureGradientLayer() {
		print("DEBUG: configureGradientLayer Started for - \(self) ")
		let gradient = CAGradientLayer()
		gradient.colors = [UIColor.systemPurple.cgColor, UIColor.systemPink.cgColor]
		gradient.locations = [0, 1]
		view.layer.addSublayer(gradient)
		gradient.frame = view.frame
	}

	//   func showLoader(_ show: Bool, withText text: String? = "Loading") {
	//      print("DEBUG: showLoader Started for - \(self)")
	//      view.endEditing(true)
	//      UIViewController.hud.textLabel.text = text
	//
	//      if show {
	//         UIViewController.hud.show(in: view)
	//      } else {
	//         UIViewController.hud.dismiss()
	//      }
	//   }
	//

	//MARK:- ConfigureNavigationBar

	func configureNavigationBar(withTitle title: String, prefersLargeTitles: Bool) {

		print("DEBUG: ConfigureNavigationBar Started for - \(self)")
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
		appearance.backgroundColor = .systemPurple

		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.compactAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance

		navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
		navigationItem.title = title
		navigationController?.navigationBar.tintColor = .white
		navigationController?.navigationBar.isTranslucent = true

		navigationController?.navigationBar.overrideUserInterfaceStyle = .dark


	}


	//MARK:- ConfigureButton

	func ConfigureButton(image: String? , selector: Selector?) -> UIBarButtonItem {

		let icon = UIImage(systemName: "\(String(describing: image?.customMirror))")
		let button = UIBarButtonItem(image: icon, style: .plain, target: self, action: selector)

		return button
	}

	func showError(_ errorMessage: String) {
		let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}

}



import UIKit

//MARK:- EXT UIColor !

extension UIColor {

	//MARK:- RGB

	static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
		return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
	}
}



//MARK:- EXT UIButton !

extension UIButton {
	// iconName - SFSymbol Name
	// size - Size of the Symbol in points
	// scale - .small, .medium, .large
	// weight - .ultralight, .thin, .light, .regular, .medium, .semibold, .bold, .heavy, .black
	// tintColor - Color of the Symbol
	// backgroundColor - Background color of the button

	//MARK:- SetSFSymbol

	func setSFSymbol(iconName: String, size: CGFloat, weight: UIImage.SymbolWeight,
					 scale: UIImage.SymbolScale, tintColor: UIColor, backgroundColor: UIColor) {
		let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: size, weight: weight, scale: scale)
		let buttonImage = UIImage(systemName: iconName, withConfiguration: symbolConfiguration)
		self.setImage(buttonImage, for: .normal)
		self.tintColor = tintColor
		self.backgroundColor = backgroundColor
	}


	//MARK:- CenterTitleVertically

	// padding - the spacing between the Image and the Title
	func centerTitleVertically(padding: CGFloat = 12.0) {
		guard let imageViewSize = self.imageView?.frame.size, let titleLabelSize = self.titleLabel?.frame.size
			else {
				return
		}

		let totalHeight = imageViewSize.height + titleLabelSize.height + padding

		self.imageEdgeInsets = UIEdgeInsets(
			top: -(totalHeight - imageViewSize.height) / 2,
			left: 0.0,
			bottom: 0.0,
			right: -titleLabelSize.width
		)

		self.titleEdgeInsets = UIEdgeInsets(
			top: 0.0,
			left: -imageViewSize.width,
			bottom: -(totalHeight - titleLabelSize.height),
			right: 0.0
		)

		self.contentEdgeInsets = UIEdgeInsets(
			top: 0.0,
			left: 0.0,
			bottom: titleLabelSize.height,
			right: 0.0
		)
	}
}


extension UIViewController {




	func anchorAll(top: NSLayoutYAxisAnchor,
				   left: NSLayoutXAxisAnchor,
				   bottom: NSLayoutYAxisAnchor,
				   right: NSLayoutXAxisAnchor,
				   paddingTop: CGFloat = 0,
				   paddingLeft: CGFloat = 0,
				   paddingBottom: CGFloat = 0,
				   paddingRight: CGFloat = 0,
				   width: CGFloat? = nil,
				   height: CGFloat? = nil) {

		view.translatesAutoresizingMaskIntoConstraints = false

		view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor ,
								  constant: paddingTop).isActive = true

		view.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,
								   constant: paddingLeft).isActive = true

		view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
									 constant: -paddingBottom).isActive = true

		view.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor,
									constant: -paddingRight).isActive = true

	}

}


extension Array  {


	struct Enque<T> {

		fileprivate var array = [T]()
		var element: T?

		//        func count() {
		//            array.count
		//        }

		mutating func enque(_ element: T) {
			array.append(element)
		}

		mutating func deque(_ element: T?) {
			if element != nil {
				array.append(element!)
			} else {
				print("Sorry there are no items to deque")
			}
		}

		func peak() {
			print("\(String(describing: array.last))")
		}

		init(element: T? = nil) {
			self.element = element

		}
	}

}



extension UIView {





	/// Calculate Number Of Items Per Row
	func calculateNumberOfItemsPerRow(size: CGFloat) -> CGFloat{

		return (frame.width / size).rounded(.down)

	}

	/// Calculate remainding space in Row
	func remainingSpace(elements: [UIView])-> CGFloat {

		let cells: [UIView] = elements

		let sum = cells.map { cell -> CGFloat in

			cell.frame.width

		}.reduce(0) { $0 + $1 }

		return  frame.width - sum
	}


	/// Returns `True / False`  based on if a new item can fit in row
	func canFitNewCellInRow(elements: [UIView])->Bool {

		let cells: [UIView] = elements

		let itemWidth = cells[0].frame.width

		let sum = cells.map { cell -> CGFloat in

			cell.frame.width

		}.reduce(0) { $0 + $1 }

		let result = sum + itemWidth <= frame.width

		return result
	}
}

extension Array {

	func sum<T: UIView >(_ array: [T]) -> CGFloat  {
		return array.map { $0.frame.width }.reduce( 0 , + )

	}

}

















