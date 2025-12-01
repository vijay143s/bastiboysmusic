import { StrictMode } from "react";
import { createRoot } from "react-dom/client";
import App from "./App.jsx";
import "./index.css";
import { UserProvider } from "./context/User.jsx";
import { SongProvider } from "./context/Song.jsx";
import axios from "axios";

// Configure axios globally to send credentials with all requests
axios.defaults.withCredentials = true;

createRoot(document.getElementById("root")).render(
  <StrictMode>
    <UserProvider>
      <SongProvider>
        <App />
      </SongProvider>
    </UserProvider>
  </StrictMode>
);
