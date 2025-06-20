class APIEndPoints {
  static const baseUrl = "http://18.189.193.38/api/v1";
  // static const baseUrl="https://jzeescollection.com/api/v1";

  static const forgotPassword = "/user/auth/forgot-password";
  static const resetPassword = "/user/auth/reset-password";
  static const changePassword = "/user/auth/change-password";
  static const userProfile = "/user/auth/profile";

  static const register = "/user/auth/register";
  static const login = "/user/auth/login";
  static const admin = "http://18.189.193.38/api/v1/auth/login";
  
  static const validatePromo = "http://18.189.193.38/api/v1/organizations/by-code";
  static const getTeams = "/teams";
  static const teamPositions = "/positions";
  static const organizations = "/organizations";
  static const adminOrganizations = "/admin/organizations";
  // static  const organizations ="/organizations";
  // static  const getPlayers ="/teams/{teamId}/players";
  static const addPlayers = "/teams";
  static const getTeamData = "/teams/";
  static const addNewGame = "/teams/";
  static const deleteTeams = "/teams/";
  static const deletePlayes = "/players/";
  static const admin_positions = "/admin/positions";
  static const admin_payments = "/admin/payments";
  static const getPromoCode = "/admin/promo-codes";
  static const getPaymentLink = "/user/subscription/generate-payment-link";
  static const reqPromoCode = "/promo-codes/redeem";
  // static  const deletePlayes ="/games/{gameId}/autocomplete-lineup";
  static const orgCode = "/user/validate-organization-access-code";

  /// payment
  static const paymentModle = "/teams/";

  /// admin
  static const adminOrgnization = "/admin/organizations";

  static const OrgnizationLogin = "$baseUrl/organization-panel/auth/login";

  static const activationHistory =
      "$baseUrl/user/organization-activation-history";

  static const promoRenewal =
      "$baseUrl/organization-panel/subscription/redeem-promo";

  static const getRenewalPaymentLink =
      "$baseUrl/organization-panel/subscription/generate-renewal-link";
}
