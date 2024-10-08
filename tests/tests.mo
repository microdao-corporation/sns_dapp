// Taken (with minor modifications) from https://github.com/NatLabs/icrc1
import Principal "mo:base/Principal";
import Debug "mo:base/Debug";

import UnitTests "w98_dapp_backend_tests/Converter.UnitTests";
import ActivationTests "w98_dapp_backend_tests/Converter.ActivationTests";
import IndexingTests "w98_dapp_backend_tests/Converter.IndexingTests";
import ConversionTests "w98_dapp_backend_tests/Converter.ConversionTests";
import BurnTests "w98_dapp_backend_tests/Converter.BurnTests";
import SettingsTests "w98_dapp_backend_tests/Converter.SettingsTests";
import CanisterTests "w98_dapp_backend_tests/Converter.CanisterTests";

import ActorSpec "/utils/ActorSpec";
import TestUtil "/utils/TestUtil";

actor Tests {
    let { run } = ActorSpec;

    let test_modules = [
        UnitTests.test,
        ActivationTests.test,
        IndexingTests.test,
        ConversionTests.test,
        BurnTests.test,
        SettingsTests.test,
        CanisterTests.test
    ];

    public func run_tests() : async () {
        let controller = await* get_controller();
        for (test in test_modules.vals()) {
            let success = ActorSpec.run([await test(controller)]);

            if (success == false) {
                Debug.trap("\1b[46;41mTests failed\1b[0m");
            } else {
                Debug.print("\1b[23;42;3m Success!\1b[0m");
            };
        };
    };

    private func get_controller() : async* Principal { 
        let controllers = await get_controllers();
        for (controller in controllers.vals()) {
            return controller;
        };
        return Principal.fromText("aaaaa-aa");
    };

    // taken from https://forum.dfinity.org/t/getting-a-canisters-controller-on-chain/7531
    let IC =
        actor "aaaaa-aa" : actor {
        // richer in ic.did
        canister_status : { canister_id : Principal } ->
            async { 
            settings : { controllers : [Principal] }
            };

        };

    private func get_controllers() : async [Principal] {
        let principal = Principal.fromActor(Tests);
        let status = await IC.canister_status({ canister_id = principal });
        return status.settings.controllers;
    };
};



