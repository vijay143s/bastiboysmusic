const { z } = require("zod");

const passwordSchema = z
  .string()
  .min(8, "Password must be at least 8 characters long")
  .regex(/[A-Z]/, "Password must contain an uppercase letter")
  .regex(/[a-z]/, "Password must contain a lowercase letter")
  .regex(/[0-9]/, "Password must contain a number");

const registerSchema = z.object({
  name: z.string().min(2, "Name must have at least 2 characters").max(191),
  email: z.string().email("Please provide a valid email address"),
  password: passwordSchema
});

const loginSchema = z.object({
  email: z.string().email("Please provide a valid email address"),
  password: z.string().min(8, "Password must be at least 8 characters long")
});

module.exports = {
  registerSchema,
  loginSchema,
};
