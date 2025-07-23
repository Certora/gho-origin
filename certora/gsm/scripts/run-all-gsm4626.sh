CMN="--compilation_steps_only"


echo
echo "******** 1. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/gho-gsm4626-inverse.conf --rule buySellInverse27 buySellInverse26 buySellInverse25 buySellInverse24 buySellInverse23 buySellInverse22 buySellInverse21 buySellInverse20 buySellInverse19 \
           --msg "1. "


echo
echo "******** 2. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/gho-gsm4626.conf \
           --msg "2. gsm4626/gho-gsm4626.conf"


echo
echo "******** 3. Running: gsm4626/balances-buy-4626.conf   ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/balances-buy-4626.conf \
           --msg "3. gsm4626/balances-buy-4626.conf"


echo
echo "******** 4. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/balances-sell-4626.conf --rule R1_getAssetAmountForSellAsset_arg_vs_return R1a_buyGhoUpdatesGhoBalanceCorrectly1 R2_getAssetAmountForSellAsset_sellAsset_eq \
           --msg "4. "


echo
echo "******** 5. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/balances-sell-4626.conf --rule R3a_sellAssetUpdatesAssetBalanceCorrectly \
           --msg "5. "


echo
echo "******** 6. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/balances-sell-4626.conf --rule R4_buyGhoUpdatesGhoBalanceCorrectly R4a_buyGhoAmountGtGhoBalanceChange \
           --msg "6. "


echo
echo "******** 7. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/fees-buy-4626.conf \
           --msg "7. "


echo
echo "******** 8. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/fees-sell-4626.conf --rule R3a_estimatedSellFeeCanBeLowerThanActualSellFee R2_getAssetAmountForSellAssetVsActualSellFee R4a_getSellFeeVsgetAssetAmountForSellAsset R4_getSellFeeVsgetAssetAmountForSellAsset R1a_getAssetAmountForSellAssetFeeNeGetSellFee R2a_getAssetAmountForSellAssetNeActualSellFee R4b_getSellFeeVsgetAssetAmountForSellAsset R1_getAssetAmountForSellAssetFeeGeGetSellFee R3b_estimatedSellFeeEqActualSellFee \
           --msg "8. "


echo
echo "******** 9a. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/gho-gsm4626-2.conf --rule accruedFeesLEGhoBalanceOfThis \
           --msg "9a. "

echo
echo "******** 9b. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/gho-gsm4626-2.conf --rule accruedFeesNeverDecrease  \
           --msg "9b. "

echo
echo "******** 9c. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/gho-gsm4626-2.conf --rule systemBalanceStabilitySell \
           --msg "9c. "

echo
echo "******** 9d. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/gho-gsm4626-2.conf --rule systemBalanceStabilityBuy \
           --msg "9d. "


echo
echo "******** 10. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/optimality4626.conf --rule R5a_externalOptimalityOfSellAsset R6a_externalOptimalityOfBuyAsset \
           --msg "10. "


echo
echo "******** 11. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/optimality4626.conf --rule R1_optimalityOfBuyAsset_v1 \
           --msg "11. "


echo
echo "******** 12. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/optimality4626.conf --rule R3_optimalityOfSellAsset_v1 \
           --msg "12. "


echo
echo "******** 13. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/getAmount-properties-4626.conf --rule getAssetAmountForBuyAsset_correctness_bound1 getAssetAmountForBuyAsset_correctness_bound2 getGhoAmountForBuyAsset_correctness_bound1 getAssetAmountForSellAsset_correctness getAssetAmountForBuyAsset_optimality getAssetAmountForBuyAsset_correctness \
           --msg "13. "


echo
echo "******** 14. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/getAmount-properties-4626.conf --rule getGhoAmountForBuyAsset_optimality \
           --msg "14. "


echo
echo "******** 15. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/getAmount-properties-4626.conf --rule getGhoAmountForBuyAsset_correctness \
           --msg "15. "


echo
echo "******** 16. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/getAmount-properties-4626.conf --rule getAssetAmountForSellAsset_optimality getAssetAmountForBuyAsset_funcProperty \
           --msg "16. "


echo
echo "******** 17. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/finishedRules-4626.conf --rule cantBuyOrSellWhenSeized cantBuyOrSellWhenFrozen sellAssetIncreasesExposure buyAssetDecreasesExposure rescuingAssetKeepsAccruedFees rescuingGhoKeepsAccruedFees giftingGhoDoesntAffectStorageSIMPLE correctnessOfBuyAsset giftingUnderlyingDoesntAffectStorageSIMPLE sellAssetSameAsGetGhoAmountForSellAsset correctnessOfSellAsset giftingGhoDoesntCreateExcessOrDearth backWithGhoDoesntCreateExcess getAssetAmountForSellAsset_correctness collectedSellFeeIsAtLeastAsRequired collectedBuyFeePlus2IsAtLeastAsRequired collectedBuyFeePlus1IsAtLeastAsRequired collectedBuyFeeIsAtLeastAsRequired sellingDoesntExceedExposureCap whoCanChangeAccruedFees whoCanChangeExposure \
           --msg "17. "


echo
echo "******** 18. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm4626/finishedRules-4626.conf --rule giftingUnderlyingDoesntCreateExcessOrDearth \
           --msg "18. "
