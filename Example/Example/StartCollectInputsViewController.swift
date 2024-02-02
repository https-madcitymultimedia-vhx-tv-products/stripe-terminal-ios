//
//  StartCollectInputsViewController.swift
//  Example
//
//  Created by Stephen Lee on 11/2/23.
//  Copyright © 2023 Stripe. All rights reserved.
//

import UIKit
import Static
import StripeTerminal

class StartCollectInputsViewController: TableViewController {

    convenience init() {
        self.init(style: .grouped)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addKeyboardDisplayObservers()
        title = "Collect Inputs"

        updateContent()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // pop if no reader is connected
        guard Terminal.shared.connectedReader != nil else {
            navigationController?.popViewController(animated: true)
            return
        }
    }

    internal func startSignatureAndSelectionForms() {
        do {
            let signatureInput = try SignatureInputBuilder(title: "Please sign")
                .setStripeDescription("Please sign if you agree to the terms and conditions")
                .setSkipButtonText("skip form")
                .setSubmitButtonText("submit signature")
                .build()


            let firstSelectionButton = try SelectionButtonBuilder(style: .primary, text: "Yes")
                .build()

            let secondSelectionButton = try SelectionButtonBuilder(style: .secondary, text: "No")
                .build()

            let selectionInput = try SelectionInputBuilder(title: "Choose an option")
                .setStripeDescription("Were you happy with customer service?")
                .setRequired(true)
                .setSelectionButtons([firstSelectionButton, secondSelectionButton])
                .build()

            let collectInputsParams = try CollectInputsParametersBuilder(
                inputs: [signatureInput, selectionInput]
            ).build()
            let vc = CollectInputsViewController(collectInputsParams: collectInputsParams)
            let navController = LargeTitleNavigationController(rootViewController: vc)
            self.present(navController, animated: true, completion: nil)
        } catch {
            self.presentAlert(error: error)
        }
    }

    internal func startTextNumericEmailPhoneForms() {
        do {
            let textInput = try TextInputBuilder(title: "Enter your name")
                .setStripeDescription("We'll need your name to look up your account")
                .setSkipButtonText("Skip")
                .setSubmitButtonText("Done")
                .build()

            let numericInput = try NumericInputBuilder(title: "Enter your zip code")
                .setSkipButtonText("Skip")
                .setSubmitButtonText("Done")
                .build()

            let emailInput = try EmailInputBuilder(title: "Enter your email address")
                .setStripeDescription("We'll send you updates on your order and occasional deals")
                .setSkipButtonText("Skip")
                .setSubmitButtonText("Done")
                .build()

            let phoneInput = try PhoneInputBuilder(title: "Enter your phone number")
                .setStripeDescription("We'll text you when your order is ready")
                .setSkipButtonText("Skip")
                .setSubmitButtonText("Done")
                .build()


            let collectInputsParams = try CollectInputsParametersBuilder(
                inputs: [textInput, numericInput, emailInput, phoneInput]
            ).build()
            let vc = CollectInputsViewController(collectInputsParams: collectInputsParams)
            let navController = LargeTitleNavigationController(rootViewController: vc)
            self.present(navController, animated: true, completion: nil)
        } catch {
            self.presentAlert(error: error)
        }
    }

    private func updateContent() {
        var sections = [Section]()
        let signatureAndSelectionForms = Section(rows: [
            Row(text: "Signature and selection forms", selection: { [unowned self] in
                self.startSignatureAndSelectionForms()
            }, cellClass: ButtonCell.self),
        ])

        let textNumericEmailPhoneForms = Section(rows: [
            Row(text: "Phone, email, numeric, and text forms", selection: { [unowned self] in
                self.startTextNumericEmailPhoneForms()
            }, cellClass: ButtonCell.self),
        ])

        sections.append(signatureAndSelectionForms)
        sections.append(textNumericEmailPhoneForms)
        dataSource.sections = sections
    }
}
