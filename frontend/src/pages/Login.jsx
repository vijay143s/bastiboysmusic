import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { UserData } from "../context/User";
import { SongData } from "../context/Song";
import Disclaimer from "../components/Disclaimer";

const Login = () => {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const { loginUser, btnLoading } = UserData();

  const { fetchSongs, fetchAlbums } = SongData();

  const navigate = useNavigate();

  const submitHandler = (e) => {
    e.preventDefault();

    loginUser(email, password, navigate, fetchSongs, fetchAlbums);
  };
  return (
    <div className="min-h-screen flex flex-col">
      {/* Main content area */}
      <div className="flex-1 flex items-center justify-center px-4">
        <div className="bg-black text-white p-8 rounded-lg shadow-lg max-w-md w-full">
          <h2 className="text-3xl font-semibold text-center mb-8">
            Login To <br></br>
            <span className="text-green-500">Basti Boys Music</span>
          </h2>

          <form className="mt-8" onSubmit={submitHandler}>
            <div className="mb-4">
              <label className="block text-sm font-medium mb-1">
                Email or username
              </label>
              <input
                type="email"
                placeholder="Email or Username"
                className="auth-input"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
              />
            </div>

            <div className="mb-4">
              <label className="block text-sm font-medium mb-1">Password</label>
              <input
                type="password"
                placeholder="Password"
                className="auth-input"
                value={password}
                onChange={(e) => setPassword(e.target.value)}
                required
              />
            </div>

            <button disabled={btnLoading} className="auth-btn">
              {btnLoading ? "Please Wait..." : "Login"}
            </button>
          </form>

          <div className="text-center mt-6">
            <Link
              to="/register"
              className="text-sm text-gray-400 hover:text-gray-300"
            >
              don't have account?
            </Link>
          </div>
        </div>
      </div>
      
      {/* Footer disclaimer */}
      <footer className="p-4">
        <div className="text-xs text-gray-500 text-center max-w-4xl mx-auto">
          <Disclaimer />
        </div>
      </footer>
    </div>
  );
};

export default Login;
