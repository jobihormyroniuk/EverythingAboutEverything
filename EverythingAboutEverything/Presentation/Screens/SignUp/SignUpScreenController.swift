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
    private let termsAndConditionsInteractiveTextIdentifier = "TermsAndConditions"
    private let signUpButtonController = AUITitleButtonController()

    // MARK: Setup

    override func setup() {
        super.setup()
        setupTapGestureRecognizer()
        setupCancelButtonController()
        setupFirstNameTextFieldInputView()
        setupLastNameTextFieldInputView()
        setupEmailTextFieldInputView()
        setupPasswordTextFieldInputView()
        setupPhoneTextFieldInputView()
        setupBirthdayTextFieldInputView()
        setupSignInButtonController()
        setupTermsAndConditionsLabel()
        setContent()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
    }

    func setupTapGestureRecognizer() {
        screenView.addGestureRecognizer(tapGestureRecognizer)
        tapGestureRecognizer.addTarget(self, action: #selector(tapGestureRecognizerAction))
    }

    func setupCancelButtonController() {
        cancelButtonController.button = screenView.cancelButton
        cancelButtonController.addDidTouchUpInsideObserver(self)
    }

    func setupFirstNameTextFieldInputView() {
        firstNameTextFieldController.returnKeyType = .next
        firstNameTextFieldController.keyboardType = .default
        firstNameTextFieldController.addDidTapReturnKeyObserver(self)
        let textInputValidator = AUIMaximumLenghtTextInputValidator(maximumLength: 16)
        firstNameTextFieldController.inputTextValidator = textInputValidator
        firstNameTextFieldInputView.textFieldController = firstNameTextFieldController
        firstNameTextFieldInputView.view = screenView.firstNameTextFieldInputView
    }

    func setupLastNameTextFieldInputView() {
        lastNameTextFieldController.returnKeyType = .next
        lastNameTextFieldController.keyboardType = .default
        lastNameTextFieldController.addDidTapReturnKeyObserver(self)
        let textInputValidator = AUIMaximumLenghtTextInputValidator(maximumLength: 24)
        lastNameTextFieldController.inputTextValidator = textInputValidator
        lastNameTextFieldInputView.textFieldController = lastNameTextFieldController
        lastNameTextFieldInputView.view = screenView.lastNameTextFieldInputView
    }

    func setupEmailTextFieldInputView() {
        emailTextFieldController.returnKeyType = .next
        emailTextFieldController.keyboardType = .emailAddress
        emailTextFieldController.addDidTapReturnKeyObserver(self)
        emailTextFieldInputView.textFieldController = emailTextFieldController
        emailTextFieldInputView.view = screenView.emailTextFieldInputView
    }

    func setupPasswordTextFieldInputView() {
        passwordTextFieldController.returnKeyType = .next
        passwordTextFieldController.keyboardType = .default
        passwordTextFieldController.autocorrectionType = .no
        passwordTextFieldController.isSecureTextEntry = true
        passwordTextFieldController.addDidTapReturnKeyObserver(self)
        let textInputValidator = AUIMaximumLenghtTextInputValidator(maximumLength: 64)
        passwordTextFieldController.inputTextValidator = textInputValidator
        passwordTextFieldInputView.textFieldController = passwordTextFieldController
        passwordTextFieldInputView.view = screenView.passwordTextFieldInputView
        securePasswordButtonController.button = screenView.securePasswordButton
        securePasswordButtonController.addDidTouchUpInsideObserver(self)
    }

    func setupPhoneTextFieldInputView() {
        phoneTextFieldController.keyboardType = .asciiCapableNumberPad
        phoneTextFieldController.addDidTapReturnKeyObserver(self)
        phoneTextFieldInputView.textFieldController = phoneTextFieldController
        phoneTextFieldInputView.view = screenView.phoneTextFieldInputView
    }

    func setupBirthdayTextFieldInputView() {
        birthdayTextFieldController.inputViewController = self.birthdayDatePickerController
        birthdayTextFieldController.addDidBeginEditingObserver(self)
        birthdayDatePickerController.maximumDate = Date()
        birthdayDatePickerController.mode = .date
        birthdayDatePickerController.addDidValueChangedObserver(self)
        birthdayTextFieldInputView.textFieldController = birthdayTextFieldController
        birthdayTextFieldInputView.view = screenView.birthdayTextFieldInputView
    }

    func setupTermsAndConditionsLabel() {
        screenView.termsAndConditionsLabel.addTarget(self, action: #selector(termsAndConditionsLabelTouchUpInside), for: .touchUpInside)
    }

    func setupSignInButtonController() {
        signUpButtonController.button = screenView.signUpButton
        signUpButtonController.addDidTouchUpInsideObserver(self)
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
            setSelectedBirtday()
        }
    }

    func controlControllerDidValueChanged(_ controlController: AUIControlController) {
        if birthdayDatePickerController === controlController {
            setSelectedBirtday()
        }
    }

    func controlControllerDidTouchUpInside(_ controlController: AUIControlController) {
        if cancelButtonController === controlController {
            cancel()
        }
        if self.securePasswordButtonController === controlController {
            securePassword()
        }
        if self.signUpButtonController === controlController {
            signUp()
        }
    }

    func textFieldControllerDidTapReturnKey(_ textFieldController: AUITextFieldController) {
        if firstNameTextFieldInputView.textFieldController === textFieldController {
            lastNameTextFieldInputView.textFieldController?.becomeFirstResponder()
        }
        if lastNameTextFieldInputView.textFieldController === textFieldController {
            emailTextFieldInputView.textFieldController?.becomeFirstResponder()
        }
        if emailTextFieldInputView.textFieldController === textFieldController {
            passwordTextFieldInputView.textFieldController?.becomeFirstResponder()
        }
        if passwordTextFieldInputView.textFieldController === textFieldController {
            phoneTextFieldInputView.textFieldController?.becomeFirstResponder()
        }
        if phoneTextFieldInputView.textFieldController === textFieldController {
            birthdayTextFieldInputView.textFieldController?.becomeFirstResponder()
        }
    }

    // MARK: Actions

    @objc func tapGestureRecognizerAction() {
        screenView.endEditing(true)
    }

    @objc func termsAndConditionsLabelTouchUpInside(interaction: String) {
        print(interaction)
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
        birthdayTextFieldInputView.textFieldController?.text = birthdayString
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
        screenView.setAgreeTermsAndConditionsText(agree: localization.localizeText("agreeTermsAndConditions", localization.localizeText("referenceTermsAndConditions") ?? "") ?? "", termsAndConditions: (localization.localizeText("referenceTermsAndConditions") ?? "", termsAndConditionsInteractiveTextIdentifier))
        signUpButtonController.title = localization.localizeText("signInButtonTitle")
    }

}
