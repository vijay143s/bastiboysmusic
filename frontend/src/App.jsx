import React from "react";
import Login from "./pages/Login";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import Home from "./pages/Home";
import Register from "./pages/Register";
import { UserData } from "./context/User";
import Loading from "./components/Loading";
import Admin from "./pages/Admin";
import PlayList from "./pages/PlayList";
import Album from "./pages/Album";
import Layout from "./components/Layout";

const App = () => {
  const { loading, isAuth } = UserData();
  return (
    <>
      {loading ? (
        <Loading />
      ) : (
        <BrowserRouter>
          {isAuth ? (
            <Layout>
              <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/playlist" element={<PlayList />} />
                <Route path="/album/:id" element={<Album />} />
                <Route path="/admin" element={<Admin />} />
                <Route path="/login" element={<Navigate to="/" replace />} />
                <Route path="/register" element={<Navigate to="/" replace />} />
                <Route path="*" element={<Navigate to="/" replace />} />
              </Routes>
            </Layout>
          ) : (
            <Routes>
              <Route path="/login" element={<Login />} />
              <Route path="/register" element={<Register />} />
              <Route path="*" element={<Navigate to="/login" replace />} />
            </Routes>
          )}
        </BrowserRouter>
      )}
    </>
  );
};

export default App;
