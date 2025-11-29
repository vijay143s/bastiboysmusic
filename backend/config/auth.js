const FALLBACK_SECRET = "dev-secret-change-me";

export const jwtSecret = process.env.Jwt_secret || FALLBACK_SECRET;

if (!process.env.Jwt_secret) {
  const runningMode = process.env.NODE_ENV || "development";
  const message =
    runningMode === "production"
      ? "Jwt_secret is missing. Using fallback value is not allowed in production."
      : "Jwt_secret not set. Using fallback development secret.";

  if (runningMode === "production") {
    throw new Error(message);
  } else {
    console.warn(message);
  }
}
