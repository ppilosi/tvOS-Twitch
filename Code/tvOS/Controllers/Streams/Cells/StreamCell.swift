// Copyright (c) 2015 Benoit Layer
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import ReactiveCocoa
import AlamofireImage

class StreamCell: UICollectionViewCell {
	static let identifier: String = "cellIdentifierStream"
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var placeholder: UIImageView!
	@IBOutlet weak var streamNameLabel: UILabel!
	@IBOutlet weak var viewersCountLabel: UILabel!
	
	private let defaultTextColor = UIColor.lightGrayColor()
	private let focusedTextColor = UIColor.whiteColor()
	private let defaultStreamFont = UIFont.boldSystemFontOfSize(18)
	private let defaultViewersFont = UIFont.systemFontOfSize(18)
	
	override func awakeFromNib() {
		super.awakeFromNib()
		imageView.layer.borderWidth = 1.0
		self.backgroundColor = UIColor.twitchLightColor()
		placeholder.image = placeholder.image?.imageWithRenderingMode(.AlwaysTemplate)
		placeholder.tintColor = UIColor.twitchDarkColor()
		streamNameLabel.textColor = defaultTextColor
		viewersCountLabel.textColor = defaultTextColor
		streamNameLabel.font = defaultStreamFont
		viewersCountLabel.font = defaultViewersFont
	}
	
	internal func bindViewModel(streamViewModel: StreamViewModel) {
		imageView.image = nil
		if let url = NSURL(string: streamViewModel.streamImageURL.value) {
			imageView.af_setImageWithURL(url)
		}
		streamNameLabel.rac_text <~ streamViewModel.streamTitle
		viewersCountLabel.rac_text <~ streamViewModel.viewersCount
	}
	
	override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
		let color = self.focused ? focusedTextColor : defaultTextColor
		let borderColor = self.focused ? UIColor.whiteColor().CGColor : UIColor.clearColor().CGColor
		coordinator.addCoordinatedAnimations({
			[weak self] in
			self?.viewersCountLabel.textColor = color
			self?.streamNameLabel.textColor = color
			self?.imageView.layer.borderColor = borderColor
			}, completion: nil)
	}
}
