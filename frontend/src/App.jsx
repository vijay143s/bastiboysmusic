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
import Search from "./pages/Search";
import Queue from "./pages/Queue";
import CommunityPlaylists from "./pages/CommunityPlaylists";
import Albums from "./pages/Albums";
import Artists from "./pages/Artists";
import Singers from "./pages/Singers";
import MusicDirectors from "./pages/MusicDirectors";
import SearchResults from "./pages/SearchResults";

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
                <Route path="/search" element={<Search />} />
                <Route path="/queue" element={<Queue />} />
                <Route path="/community" element={<CommunityPlaylists />} />
                <Route path="/admin" element={<Admin />} />
                <Route path="/albums" element={<Albums />} />
                <Route path="/artists" element={<Artists />} />
                <Route path="/singers" element={<Singers />} />
                <Route path="/music-directors" element={<MusicDirectors />} />
                <Route path="/results/:type/:id" element={<SearchResults />} />
                <Route path="/results/:type/:name" element={<SearchResults />} />
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
