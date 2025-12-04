import { createRoot } from "react-dom/client";
import App from "./App.jsx";
import "./index.css";
import { UserProvider } from "./context/User.jsx";
import { SongProvider } from "./context/Song.jsx";
import { LanguageProvider } from "./context/Language.jsx";

createRoot(document.getElementById("root")).render(
  <UserProvider>
    <LanguageProvider>
      <SongProvider>
        <App />
      </SongProvider>
    </LanguageProvider>
  </UserProvider>
);

