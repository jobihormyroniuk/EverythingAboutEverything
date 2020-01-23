//
//  TextFieldInputView.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 10/18/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit
import ACoreAnimation

class LeftIconedCenterTitledBottomUnderlinedTextFieldInputView: AUIView, AUITextFieldTextInputView, AUIResponsiveTextInputView, CAAnimationDelegate {
    
    // MARK: Elements
    
    let iconImageView = AUIImageViewContentModeScaleAspectFit()
    let textField = UITextField()
    let placeholderTextLayer = ACATextLayerVerticalTextAlignmentCenter()
    let underlineView = UIView()
    
    // MARK: Setup
    
    override func setup() {
        super.setup()
        placeholderTextLayer.contentsGravity = .center
        //backgroundColor = .green
        addSubview(iconImageView)
        setupIconImageView()
        addSubview(textField)
        setupTextField()
        layer.addSublayer(placeholderTextLayer)
        setupPlaceholderTextLayer()
        addSubview(underlineView)
        setupUnderlineLayer()
    }
    
    func setupIconImageView() {
        
    }
    
    func setupTextField() {
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    }
    
    func setupPlaceholderTextLayer() {
        placeholderTextLayer.string = "sdfsd sdfsdf"
        placeholderTextLayer.foregroundColor = UIColor(red8Bits: 153, green8Bits: 153, blue8Bits: 153).cgColor
        placeholderTextLayer.font = UIFont.systemFont(ofSize: 15.0).cgFont
        placeholderTextLayer.fontSize = 15
        //placeholderTextLayer.backgroundColor = UIColor.yellow.cgColor
    }
    
    func setupUnderlineLayer() {
        underlineView.backgroundColor = UIColor(red8Bits: 204, green8Bits: 204, blue8Bits: 204)
    }
    
    // MARK: Layout
    
    override func layout() {
        super.layout()
        layoutIconImageView()
        layoutTextField()
        layoutPlaceholderTextLayer()
        layoutUnderlineView()
    }
    
    func layoutIconImageView() {
        let width: CGFloat = 24
        let height: CGFloat = 23
        let x: CGFloat = 0
        let y: CGFloat = 17
        let frame = CGRect(x: x, y: y, width: width, height: height)
        iconImageView.frame = frame
    }
    
    func layoutTextField() {
        let x: CGFloat = 33
        let width: CGFloat = bounds.size.width - x
        let height: CGFloat = 24
        let y: CGFloat = 17
        let frame = CGRect(x: x, y: y, width: width, height: height)
        textField.frame = frame
    }
    
    var placeholderTextLayerFrame: CGRect?
    func layoutPlaceholderTextLayer() {
        let anchorPoint = CGPoint(x: 0, y: 0)
        guard let placeholderTextLayerFrame = placeholderTextLayerFrame else {
            placeholderTextLayer.anchorPoint = anchorPoint
            let x: CGFloat = 33
            let width: CGFloat = bounds.size.width - x
            let height: CGFloat = 24
            let y: CGFloat = 17
            let frame = CGRect(x: x, y: y, width: width, height: height)
            placeholderTextLayer.frame = frame
            return
        }
        placeholderTextLayer.frame = placeholderTextLayerFrame
    }
    
    func layoutUnderlineView() {
        let x: CGFloat = 33
        let width: CGFloat = bounds.size.width - x
        let height: CGFloat = 1
        let y: CGFloat = bounds.size.height - 16 - height
        let frame = CGRect(x: x, y: y, width: width, height: height)
        underlineView.frame = frame
    }
    
    // MARK: AUIResponsiveSubtextInputView
    
    func responsiveTextInputViewDidBeginEditingEmpty(animated: Bool) {

        var bounds = placeholderTextLayer.bounds
        bounds.size.height = 16
        let placeholderBoudsAnimation = CABasicAnimation(keyPath: "bounds")
        //placeholderBoudsAnimation.
        placeholderBoudsAnimation.fromValue = placeholderTextLayer.bounds
        placeholderBoudsAnimation.toValue = bounds
        
        var position = placeholderTextLayer.position
        position.y = 0
        let placeholderPositionAnimation = CABasicAnimation(keyPath: "position")
        placeholderPositionAnimation.fromValue = placeholderTextLayer.position
        placeholderPositionAnimation.toValue = position
        
        let foregroundColor = UIColor(red8Bits: 60, green8Bits: 144, blue8Bits: 229).cgColor
        let placeholderForegroundColorAnimation = CABasicAnimation(keyPath: "foregroundColor")
        placeholderForegroundColorAnimation.fromValue = placeholderTextLayer.foregroundColor
        placeholderForegroundColorAnimation.toValue = foregroundColor
        
        let fontSize = CGFloat(12)
        let placeholderFontSizeAnimation = CABasicAnimation(keyPath: "fontSize")
        placeholderFontSizeAnimation.fromValue = placeholderTextLayer.fontSize
        placeholderFontSizeAnimation.toValue = fontSize
        
        let font = UIFont.systemFont(ofSize: 12, weight: .medium).cgFont
        let placeholderFontAnimation = CABasicAnimation(keyPath: "font")
        placeholderFontAnimation.fromValue = placeholderTextLayer.font
        placeholderFontAnimation.toValue = font
        
        let animations = CAAnimationGroup()
        animations.animations = [placeholderBoudsAnimation, placeholderPositionAnimation, placeholderForegroundColorAnimation, placeholderFontSizeAnimation, placeholderFontAnimation]
        //animations.duration = 4
        animations.isRemovedOnCompletion = false
        animations.fillMode = .forwards
        
        animations.delegate = self
        placeholderTextLayer.add(animations, forKey: "responsiveTextInputViewDidBeginEditingEmpty")

        let underlineForegroundColor = UIColor(red8Bits: 60, green8Bits: 144, blue8Bits: 229).cgColor
        let underlineFlaceholderForegroundColorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        underlineFlaceholderForegroundColorAnimation.fromValue = underlineView.layer.backgroundColor
        underlineFlaceholderForegroundColorAnimation.toValue = underlineForegroundColor

        underlineView.layer.add(underlineFlaceholderForegroundColorAnimation, forKey: "fff")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if placeholderTextLayer.animation(forKey: "responsiveTextInputViewDidBeginEditingEmpty") == anim {
            placeholderTextLayer.removeAnimation(forKey: "responsiveTextInputViewDidBeginEditingEmpty")
            editing()
        }
    }

    private func editing() {
        var bounds = placeholderTextLayer.bounds
        bounds.size.height = 16
        var position = placeholderTextLayer.position
        position.y = 0
        let foregroundColor = UIColor(red8Bits: 60, green8Bits: 144, blue8Bits: 229).cgColor
        let fontSize = CGFloat(12)
        let font = UIFont.systemFont(ofSize: 12, weight: .medium).cgFont
        placeholderTextLayerFrame = CGRect(origin: position, size: bounds.size)
        placeholderTextLayer.foregroundColor = foregroundColor
        placeholderTextLayer.fontSize = fontSize
        placeholderTextLayer.font = font
        //layoutIfNeeded()
    }

    private func nonEditing() {

    }
    
    func responsiveTextInputViewDidBeginEditingNonempty(animated: Bool) {
        var bounds = placeholderTextLayer.bounds
        bounds.size.height = 16
        let placeholderBoudsAnimation = CABasicAnimation(keyPath: "bounds")
        placeholderBoudsAnimation.fromValue = placeholderTextLayer.bounds
        placeholderBoudsAnimation.toValue = bounds
        
        var position = placeholderTextLayer.position
        position.y = 0
        let placeholderPositionAnimation = CABasicAnimation(keyPath: "position")
        placeholderPositionAnimation.fromValue = placeholderTextLayer.position
        placeholderPositionAnimation.toValue = position
        
        let foregroundColor = UIColor(red8Bits: 60, green8Bits: 144, blue8Bits: 229).cgColor
        let placeholderForegroundColorAnimation = CABasicAnimation(keyPath: "foregroundColor")
        placeholderForegroundColorAnimation.fromValue = placeholderTextLayer.foregroundColor
        placeholderForegroundColorAnimation.toValue = foregroundColor
        
        let fontSize = CGFloat(12)
        let placeholderFontSizeAnimation = CABasicAnimation(keyPath: "fontSize")
        placeholderFontSizeAnimation.fromValue = placeholderTextLayer.fontSize
        placeholderFontSizeAnimation.toValue = fontSize
        
        let font = UIFont.systemFont(ofSize: 12, weight: .medium).cgFont
        let placeholderFontAnimation = CABasicAnimation(keyPath: "font")
        placeholderFontAnimation.fromValue = placeholderTextLayer.font
        placeholderFontAnimation.toValue = font
        
        let animations = CAAnimationGroup()
        animations.animations = [placeholderBoudsAnimation, placeholderPositionAnimation, placeholderForegroundColorAnimation, placeholderFontSizeAnimation, placeholderFontAnimation]
        //animations.duration = 2.0
        //animations.isRemovedOnCompletion = false
        //animations.fillMode = .removed
        //placeholderTextLayer.add(animations, forKey: nil)
        
        placeholderTextLayer.position = position
        placeholderTextLayer.bounds = bounds
        placeholderTextLayerFrame = CGRect(origin: position, size: bounds.size)
        placeholderTextLayer.foregroundColor = foregroundColor
        placeholderTextLayer.fontSize = fontSize
        placeholderTextLayer.font = font
    }
    
    func responsiveTextInputViewDidBecomeEmpty(animated: Bool) {
        
    }
    
    func responsiveTextInputViewDidBecomeNonEmpty(animated: Bool) {
        
    }
    
    func responsiveTextInputViewDidEndEditingEmpty(animated: Bool) {
        var bounds = placeholderTextLayer.bounds
        bounds.size.height = 24
        let placeholderBoudsAnimation = CABasicAnimation(keyPath: "bounds")
        placeholderBoudsAnimation.fromValue = placeholderTextLayer.bounds
        placeholderBoudsAnimation.toValue = bounds
        
        var position = placeholderTextLayer.position
        position.y = 17
        let placeholderPositionAnimation = CABasicAnimation(keyPath: "position")
        placeholderPositionAnimation.fromValue = placeholderTextLayer.position
        placeholderPositionAnimation.toValue = position
        
        let foregroundColor = UIColor(red8Bits: 153, green8Bits: 153, blue8Bits: 153).cgColor
        let placeholderForegroundColorAnimation = CABasicAnimation(keyPath: "foregroundColor")
        placeholderForegroundColorAnimation.fromValue = placeholderTextLayer.foregroundColor
        placeholderForegroundColorAnimation.toValue = foregroundColor
        
        let fontSize = CGFloat(15)
        let placeholderFontSizeAnimation = CABasicAnimation(keyPath: "fontSize")
        placeholderFontSizeAnimation.fromValue = placeholderTextLayer.fontSize
        placeholderFontSizeAnimation.toValue = fontSize
        
        let font = UIFont.systemFont(ofSize: 15).cgFont
        let placeholderFontAnimation = CABasicAnimation(keyPath: "font")
        placeholderFontAnimation.fromValue = placeholderTextLayer.font
        placeholderFontAnimation.toValue = font
        
        let animations = CAAnimationGroup()
        animations.animations = [placeholderBoudsAnimation, placeholderPositionAnimation, placeholderForegroundColorAnimation, placeholderFontSizeAnimation, placeholderFontAnimation]
        //animations.duration = 2.0
        //animations.isRemovedOnCompletion = false
        //animations.fillMode = .removed
        //placeholderTextLayer.add(animations, forKey: nil)
        
        placeholderTextLayer.position = position
        placeholderTextLayer.bounds = bounds
        placeholderTextLayerFrame = CGRect(origin: position, size: bounds.size)
        placeholderTextLayer.foregroundColor = foregroundColor
        placeholderTextLayer.fontSize = fontSize
        placeholderTextLayer.font = font
    }
    
    func responsiveTextInputViewDidEndEditingNonempty(animated: Bool) {
        var bounds = placeholderTextLayer.bounds
        bounds.size.height = 16
        let placeholderBoudsAnimation = CABasicAnimation(keyPath: "bounds")
        placeholderBoudsAnimation.fromValue = placeholderTextLayer.bounds
        placeholderBoudsAnimation.toValue = bounds
        
        var position = placeholderTextLayer.position
        position.y = 0
        let placeholderPositionAnimation = CABasicAnimation(keyPath: "position")
        placeholderPositionAnimation.fromValue = placeholderTextLayer.position
        placeholderPositionAnimation.toValue = position
        
        let foregroundColor = UIColor(red8Bits: 153, green8Bits: 153, blue8Bits: 153).cgColor
        let placeholderForegroundColorAnimation = CABasicAnimation(keyPath: "foregroundColor")
        placeholderForegroundColorAnimation.fromValue = placeholderTextLayer.foregroundColor
        placeholderForegroundColorAnimation.toValue = foregroundColor
        
        let fontSize = CGFloat(12)
        let placeholderFontSizeAnimation = CABasicAnimation(keyPath: "fontSize")
        placeholderFontSizeAnimation.fromValue = placeholderTextLayer.fontSize
        placeholderFontSizeAnimation.toValue = fontSize
        
        let font = UIFont.systemFont(ofSize: 12, weight: .medium).cgFont
        let placeholderFontAnimation = CABasicAnimation(keyPath: "font")
        placeholderFontAnimation.fromValue = placeholderTextLayer.font
        placeholderFontAnimation.toValue = font
        
        let animations = CAAnimationGroup()
        animations.animations = [placeholderBoudsAnimation, placeholderPositionAnimation, placeholderForegroundColorAnimation, placeholderFontSizeAnimation, placeholderFontAnimation]
        //animations.duration = 2.0
        //animations.isRemovedOnCompletion = false
        //animations.fillMode = .removed
        //placeholderTextLayer.add(animations, forKey: nil)
        
        placeholderTextLayer.position = position
        placeholderTextLayer.bounds = bounds
        placeholderTextLayerFrame = CGRect(origin: position, size: bounds.size)
        placeholderTextLayer.foregroundColor = foregroundColor
        placeholderTextLayer.fontSize = fontSize
        placeholderTextLayer.font = font
    }
    
}

public extension UIFont {
    
    var cgFont: CGFont? {
        return CGFont(fontName as NSString)
    }
    
}
