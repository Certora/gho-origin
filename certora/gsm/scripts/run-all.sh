#CMN="--compilation_steps_only"

echo
echo "******** 1. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/gho-gsm_inverse.conf \
           --msg "1. "

echo
echo "******** 2. Running: gsm/gho-gsm.conf   ****************"
certoraRun $CMN certora/gsm/conf/gsm/gho-gsm.conf \
           --msg "2. gsm/gho-gsm.conf"

echo
echo "******** 3. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/balances-buy.conf \
           --msg "3. "

echo
echo "******** 4. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/balances-sell.conf \
           --msg "4. "

echo
echo "******** 5. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/gho-assetToGhoInvertibility.conf --rule basicProperty_getAssetAmountForBuyAsset sellAssetInverse_all buyAssetInverse_all basicProperty_getGhoAmountForSellAsset basicProperty_getAssetAmountForSellAsset basicProperty_getGhoAmountForBuyAsset \
           --msg "5. "

echo
echo "******** 6. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/gho-assetToGhoInvertibility.conf --rule basicProperty2_getAssetAmountForBuyAsset \
           --msg "6. "

echo
echo "******** 7. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/gho-fixedPriceStrategy.conf \
           --msg "7. "

echo
echo "******** 8. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/fees-buy.conf \
           --msg "8. "

echo
echo "******** 9. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/fees-sell.conf \
           --msg "9. "

echo
echo "******** 10. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/FixedFeeStrategy.conf \
           --msg "10. "

echo
echo "******** 11. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/gho-gsm.conf \
           --msg "11. "

echo
echo "******** 12. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/optimality.conf --rule R3_optimalityOfSellAsset_v1 R1_optimalityOfBuyAsset_v1 R6a_externalOptimalityOfBuyAsset R5a_externalOptimalityOfSellAsset R2_optimalityOfBuyAsset_v2 \
           --msg "12. "

echo
echo "******** 13. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/getAmount_properties.conf --rule getAssetAmountForBuyAsset_funcProperty_LR getAssetAmountForBuyAsset_funcProperty_RL \
           --msg "13. "

echo
echo "******** 14. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/finishedRules.conf --rule whoCanChangeExposure whoCanChangeAccruedFees sellingDoesntExceedExposureCap cantBuyOrSellWhenSeized giftingGhoDoesntAffectStorageSIMPLE giftingUnderlyingDoesntAffectStorageSIMPLE collectedBuyFeePlus1IsAtLeastAsRequired sellAssetSameAsGetGhoAmountForSellAsset collectedSellFeeIsAtLeastAsRequired collectedBuyFeeIsAtLeastAsRequired correctnessOfBuyAsset collectedBuyFeePlus2IsAtLeastAsRequired getAssetAmountForSellAsset_correctness cantBuyOrSellWhenFrozen whoCanChangeExposureCap cantSellIfExposureTooHigh sellAssetIncreasesExposure buyAssetDecreasesExposure rescuingGhoKeepsAccruedFees rescuingAssetKeepsAccruedFees \
           --msg "14. "


echo
echo "******** 15. Running:    ****************"
certoraRun $CMN certora/gsm/conf/gsm/OracleSwapFreezer.conf \
           --msg "15. "

