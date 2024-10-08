# w98_sns_dapp
W98 SNS dApp

  ```motoko    
To install and run tests locally:
    git clone https://github.com/icw98/w98_sns_dapp
    cd w98_sns_dapp
    npm install
    dfx start 

In a new console, also in w98_sns_dapp directory:
    dfx deploy w98_dapp_backend --specified-id "bd3sg-teaaa-aaaaa-qaaba-cai"
    dfx deploy w98_dapp_frontend --specified-id "bkyz2-fmaaa-aaaaa-qaaaq-cai"
    dfx deploy w98_dapp_tests --specified-id "by6od-j4aaa-aaaaa-qaadq-cai"
    dfx deploy w98_dapp_old_token_mock --specified-id "b77ix-eeaaa-aaaaa-qaada-cai"
    dfx deploy w98_dapp_new_token_mock --specified-id "br5f7-7uaaa-aaaaa-qaaca-cai"
    dfx deploy w98_dapp_old_indexer_mock --specified-id "bw4dl-smaaa-aaaaa-qaacq-cai"
    dfx deploy w98_dapp_new_indexer_mock --specified-id "be2us-64aaa-aaaaa-qaabq-cai"

Then, to run the tests:
    dfx canister call w98_dapp_tests run_tests

A return value of () means all tests ran successfully. You can also check the first console in which you ran dfx start to see the test output. 

To test that state is preserved between updates:
    dfx canister call w98_dapp_backend burn_old_tokens '(1_000)' 

It is expected that this call returns an error: (variant { Err = variant { NotActive } })

Then check the log size before and after updating the canisters:    
    dfx canister call w98_dapp_backend get_log_size
    dfx deploy
    dfx canister call w98_dapp_backend get_log_size

Make sure that get_log_size returns the same number both calls, and that it is a value greater than zero (expected value would be 2). 


