part of 'internal.dart';

/// Allows for passing user privacy consent information.
class PrivacySettings {
  PrivacySettings._();

  /// Updates GDPR consent data
  ///
  /// The [consentString] should be a correct string formatted according to [IAB specification](https://github.com/InteractiveAdvertisingBureau/GDPR-Transparency-and-Consent-Framework/blob/master/Consent%20string%20and%20vendor%20list%20formats%20v1.1%20Final.md)
  ///
  static Future<void> updateGDPRConsent(
      {@required bool grantsConsent, String consentString}) {
    assert(grantsConsent != null);
    final params = <String, Object>{
      "grantConsent": grantsConsent,
      if (consentString != null) "consentString": consentString,
    };
    return FairBidInternal._channel.invokeMethod("updateGDPR", params);
  }

  /// Clears GDPR related data
  static Future<void> clearGDPRConsent() =>
      FairBidInternal._channel.invokeMethod("clearGDPR");

  /// Updates CCPA privacy string (also known as IAB US privacy string)
  ///
  /// The `consentString` should be a correct string formatted according to [IAB specification](https://iabtechlab.com/standards/ccpa/)
  ///
  static Future<void> updateCCPAString({String ccpaString}) {
    final params = <String, Object>{
      if (ccpaString != null) "ccpaString": ccpaString,
    };
    return FairBidInternal._channel.invokeMethod("updateCCPA", params);
  }

  /// Clears CCPA privacy string
  static Future<void> clearCCPAString() =>
      FairBidInternal._channel.invokeMethod("clearCCPA");

  /// Clears all privacy settings
  static Future<void> clear() => Future.wait([
        clearGDPRConsent(),
        clearCCPAString(),
      ]);
}
