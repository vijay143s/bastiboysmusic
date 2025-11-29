import { ZodError } from "zod";

export const validateRequest = (schema) => (req, res, next) => {
  try {
    req.body = schema.parse(req.body);
    next();
  } catch (error) {
    if (error instanceof ZodError) {
      const formatted = error.issues.map((issue) => ({
        path: issue.path.join("."),
        message: issue.message
      }));

      return res.status(422).json({
        success: false,
        message: formatted[0]?.message || "Invalid request payload",
        errors: formatted
      });
    }

    return res.status(500).json({
      success: false,
      message: "Unable to process the request payload"
    });
  }
};
