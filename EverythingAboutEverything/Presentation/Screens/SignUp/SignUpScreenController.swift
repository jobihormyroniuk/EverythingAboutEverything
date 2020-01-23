//
//  SignUpScreenController.swift
//  EverythingAboutEverything
//
//  Created by Ihor Myroniuk on 11/20/19.
//  Copyright © 2019 Ihor Myroniuk. All rights reserved.
//

import UIKit
import AUIKit
import AFoundation
import AnyFormatKit

class SignUpScreenController: AUIDefaultScreenController, AUIControlControllerDidValueChangedObserver, AUITextFieldControllerDidBeginEditingObserver, AUIControlControllerDidTouchUpInsideObserver, AUITextFieldControllerDidTapReturnKeyObserver {

    // MARK: Localization

    let localization = CompositeLocalizer(textLocalization: TableNameBundleTextLocalizer(tableName: "SignUpScreenStrings"))

    // MARK: View

    private var screenView: SignUpScreenView! {
        return self.view as? SignUpScreenView
    }

    // MARK: Elements

    private let tapGestureRecognizer = UITapGestureRecognizer()
    private let cancelButtonController = AUITitleButtonController()

    private let firstNameTextFieldController = AUITextInputFilterValidatorFormatterTextFieldController()
    private let firstNameTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()

    private let lastNameTextFieldController = AUITextInputFilterValidatorFormatterTextFieldController()
    private let lastNameTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()

    private let emailTextFieldController = AUIEmptyTextFieldController()
    private let emailTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()

    private let passwordTextFieldController = AUITextInputFilterValidatorFormatterTextFieldController()
    private let passwordTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()
    private let securePasswordButtonController = AUITitleButtonController()

    private let phoneTextFieldController = AUITextInputFilterValidatorFormatterTextFieldController()
    private let phoneTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()

    private let birthdayTextFieldController = AUIEmptyTextFieldController()
    private let birthdayTextFieldInputView = AUIResponsiveTextFieldTextInputViewController()
    private let birthdayDatePickerController = AUIDefaultDatePickerController()
    
    private let signUpButtonController = AUITitleButtonController()

    // MARK: Setup

    override func setup() {
        super.setup()
        self.setupTapGestureRecognizer()
        self.setupCancelButtonController()
        self.setupFirstNameTextFieldInputView()
        self.setupLastNameTextFieldInputView()
        self.setupEmailTextFieldInputView()
        self.setupPasswordTextFieldInputView()
        self.setupPhoneTextFieldInputView()
        self.setupBirthdayTextFieldInputView()
        self.setupSignInButtonController()
        self.setContent()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    func setupTapGestureRecognizer() {
        screenView.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(tapGestureRecognizerAction))
    }

    func setupCancelButtonController() {
        self.cancelButtonController.button = self.screenView.cancelButton
        self.cancelButtonController.addDidTouchUpInsideObserver(self)
    }

    func setupFirstNameTextFieldInputView() {
        firstNameTextFieldController.returnKeyType = .next
        firstNameTextFieldController.keyboardType = .default
        firstNameTextFieldController.addDidTapReturnKeyObserver(self)
        let textInputValidator = AUIMaximumLenghtTextInputValidator(maximumLength: 16)
        firstNameTextFieldController.inputTextValidator = textInputValidator
        self.firstNameTextFieldInputView.textFieldController = firstNameTextFieldController
        self.firstNameTextFieldInputView.view = self.screenView.firstNameTextFieldInputView
    }

    func setupLastNameTextFieldInputView() {
        lastNameTextFieldController.returnKeyType = .next
        lastNameTextFieldController.keyboardType = .default
        lastNameTextFieldController.addDidTapReturnKeyObserver(self)
        let textInputValidator = AUIMaximumLenghtTextInputValidator(maximumLength: 24)
        lastNameTextFieldController.inputTextValidator = textInputValidator
        self.lastNameTextFieldInputView.textFieldController = lastNameTextFieldController
        self.lastNameTextFieldInputView.view = self.screenView.lastNameTextFieldInputView
    }

    func setupEmailTextFieldInputView() {
        emailTextFieldController.returnKeyType = .next
        emailTextFieldController.keyboardType = .emailAddress
        emailTextFieldController.addDidTapReturnKeyObserver(self)
        self.emailTextFieldInputView.textFieldController = emailTextFieldController
        self.emailTextFieldInputView.view = self.screenView.emailTextFieldInputView
    }

    func setupPasswordTextFieldInputView() {
        passwordTextFieldController.returnKeyType = .next
        passwordTextFieldController.keyboardType = .default
        passwordTextFieldController.autocorrectionType = .no
        passwordTextFieldController.isSecureTextEntry = true
        passwordTextFieldController.addDidTapReturnKeyObserver(self)
        let textInputValidator = AUIMaximumLenghtTextInputValidator(maximumLength: 64)
        passwordTextFieldController.inputTextValidator = textInputValidator
        self.passwordTextFieldInputView.textFieldController = passwordTextFieldController
        self.passwordTextFieldInputView.view = self.screenView.passwordTextFieldInputView
        self.securePasswordButtonController.button = self.screenView.securePasswordButton
        self.securePasswordButtonController.addDidTouchUpInsideObserver(self)
    }

    func setupPhoneTextFieldInputView() {
        let anyFormatKitTextInputFormatter = DefaultTextInputFormatter(textPattern: "(###) ### ###")
        let textInputFormatter = AnyFormatKitTextInputFormatterAdapterToAUITextInputFormatter(anyFormatKitTextInputFormatter: anyFormatKitTextInputFormatter)
        phoneTextFieldController.inputTextFormatter = textInputFormatter
        phoneTextFieldController.keyboardType = .asciiCapableNumberPad
        phoneTextFieldController.addDidTapReturnKeyObserver(self)
        self.phoneTextFieldInputView.textFieldController = phoneTextFieldController
        self.phoneTextFieldInputView.view = self.screenView.phoneTextFieldInputView
    }

    func setupBirthdayTextFieldInputView() {
        birthdayTextFieldController.inputViewController = self.birthdayDatePickerController
        birthdayTextFieldController.addDidBeginEditingObserver(self)
        self.birthdayDatePickerController.maximumDate = Date()
        self.birthdayDatePickerController.mode = .date
        self.birthdayDatePickerController.addDidValueChangedObserver(self)
        self.birthdayTextFieldInputView.textFieldController = birthdayTextFieldController
        self.birthdayTextFieldInputView.view = self.screenView.birthdayTextFieldInputView
    }

    func setupSignInButtonController() {
        self.signUpButtonController.button = self.screenView.signUpButton
        self.signUpButtonController.addDidTouchUpInsideObserver(self)
    }

    // MARK: Events

    @objc func keyboardDidShow(_ notification: Notification) {
        if let keyboardFrameValue: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardFrameValue.cgRectValue
            screenView.keyboardDidShow(keyboardFrame)
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if let keyboardFrameValue: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardFrame = keyboardFrameValue.cgRectValue
            screenView.keyboardWillHide(keyboardFrame)
        }
    }

    func textFieldControllerDidBeginEditing(_ textFieldController: AUITextFieldController) {
        if self.birthdayTextFieldInputView.textFieldController === textFieldController {
            self.setSelectedBirtday()
        }
    }

    func controlControllerDidValueChanged(_ controlController: AUIControlController) {
        if self.birthdayDatePickerController === controlController {
            self.setSelectedBirtday()
        }
    }

    func controlControllerDidTouchUpInside(_ controlController: AUIControlController) {
        if self.cancelButtonController === controlController {
            self.cancel()
        }
        if self.securePasswordButtonController === controlController {
            self.securePassword()
        }
        if self.signUpButtonController === controlController {
            self.signUp()
        }
    }

    func textFieldControllerDidTapReturnKey(_ textFieldController: AUITextFieldController) {
        if firstNameTextFieldInputView.textFieldController === textFieldController {
            self.lastNameTextFieldInputView.textFieldController?.becomeFirstResponder()
        }
        if lastNameTextFieldInputView.textFieldController === textFieldController {
            self.emailTextFieldInputView.textFieldController?.becomeFirstResponder()
        }
        if emailTextFieldInputView.textFieldController === textFieldController {
            self.passwordTextFieldInputView.textFieldController?.becomeFirstResponder()
        }
        if passwordTextFieldInputView.textFieldController === textFieldController {
            self.phoneTextFieldInputView.textFieldController?.becomeFirstResponder()
        }
        if phoneTextFieldInputView.textFieldController === textFieldController {
            self.birthdayTextFieldInputView.textFieldController?.becomeFirstResponder()
        }
    }

    // MARK: Actions

    @objc func tapGestureRecognizerAction() {
        self.screenView.endEditing(true)
    }

    func cancel() {
        print("cancel")
    }

    func securePassword() {
        if passwordTextFieldInputView.textFieldController?.isSecureTextEntry == true {
            passwordTextFieldInputView.textFieldController?.isSecureTextEntry = false
        } else {
            passwordTextFieldInputView.textFieldController?.isSecureTextEntry = true
        }
    }

    func setSelectedBirtday() {
        let birthday = self.birthdayDatePickerController.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        let birthdayString = dateFormatter.string(from: birthday)
        self.birthdayTextFieldInputView.textFieldController?.text = birthdayString
    }

    func signUp() {
        let firstName = firstNameTextFieldController.text
        let lastName = lastNameTextFieldController.text
        let email = emailTextFieldController.text
        let phone = phoneTextFieldController.text
        let password = passwordTextFieldController.text
        let birthday = (birthdayTextFieldController.text?.isEmpty ?? true) ? nil : birthdayDatePickerController.date

        print("First Name: \(String(describing: firstName))")
        print("Last Name: \(String(describing: lastName))")
        print("Email: \(String(describing: email))")
        print("Phone: \(String(describing: phone))")
        print("Password: \(String(describing: password))")
        print("Birthday: \(String(describing: birthday))")
    }

    // MARK: Content

    func setContent() {
        cancelButtonController.title = localization.localizeText("cancelButtonTitle")
        screenView.titleLabel.text = localization.localizeText("screenTitle")
        screenView.firstNameTextFieldInputView.titleTextLayer.string = localization.localizeText("firstNameInputViewTitlePlaceholder")
        screenView.lastNameTextFieldInputView.titleTextLayer.string = localization.localizeText("lastNameInputViewTitlePlaceholder")
        screenView.emailTextFieldInputView.titleTextLayer.string = localization.localizeText("emailInputViewTitlePlaceholder")
        screenView.passwordTextFieldInputView.titleTextLayer.string = localization.localizeText("passwordInputViewTitlePlaceholder")
        screenView.phoneTextFieldInputView.titleTextLayer.string = localization.localizeText("phoneInputViewTitlePlaceholder")
        screenView.birthdayTextFieldInputView.titleTextLayer.string = localization.localizeText("birthdayInputViewTitlePlaceholder")
        screenView.setAgreeTermsAndConditionsText(agree: localization.localizeText("agreeTermsAndConditions", localization.localizeText("referenceTermsAndConditions") ?? "") ?? "", termsAndConditions: localization.localizeText("referenceTermsAndConditions") ?? "")
        signUpButtonController.title = localization.localizeText("signInButtonTitle")
    }

}
