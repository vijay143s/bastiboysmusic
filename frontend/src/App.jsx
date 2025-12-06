import React, { Suspense, lazy } from "react";
import { BrowserRouter, Routes, Route, Navigate } from "react-router-dom";
import { UserData } from "./context/User";
import Loading from "./components/Loading";
import Layout from "./components/Layout";

// Lazy load pages
const Home = lazy(() => import("./pages/Home"));
const Login = lazy(() => import("./pages/Login"));
const Register = lazy(() => import("./pages/Register"));
const Admin = lazy(() => import("./pages/Admin"));
const PlayList = lazy(() => import("./pages/PlayList"));
const Album = lazy(() => import("./pages/Album"));
const Search = lazy(() => import("./pages/Search"));
const Queue = lazy(() => import("./pages/Queue"));
const CommunityPlaylists = lazy(() => import("./pages/CommunityPlaylists"));
const Albums = lazy(() => import("./pages/Albums"));
const Artists = lazy(() => import("./pages/Artists"));
const Singers = lazy(() => import("./pages/Singers"));
const MusicDirectors = lazy(() => import("./pages/MusicDirectors"));
const SearchResults = lazy(() => import("./pages/SearchResults"));
const Years = lazy(() => import("./pages/Years"));
const ScraperDashboard = lazy(() => import("./pages/ScraperDashboard"));
const DatabaseQueryPage = lazy(() => import("./pages/DatabaseQueryPage"));

const App = () => {
  const { loading, isAuth } = UserData();
  return (
    <>
      {loading ? (
        <Loading />
      ) : (
        <BrowserRouter>
          <Suspense fallback={<Loading />}>
            {isAuth ? (
              <Layout>
                <Routes>
                  <Route path="/" element={<Home />} />
                  <Route path="/playlist" element={<PlayList />} />
                  <Route path="/album/:id" element={<Album />} />
                  <Route path="/search" element={<Search />} />
                  <Route path="/queue" element={<Queue />} />
                  <Route path="/years" element={<Years />} />
                  <Route path="/community" element={<CommunityPlaylists />} />
                  <Route path="/admin" element={<Admin />} />
                  <Route path="/database-admin" element={<DatabaseQueryPage />} />
                  <Route path="/scraper" element={<ScraperDashboard />} />
                  <Route path="/albums" element={<Albums />} />
                  <Route path="/artists" element={<Artists />} />
                  <Route path="/singers" element={<Singers />} />
                  <Route path="/music-directors" element={<MusicDirectors />} />
                  <Route path="/results/:type/:idOrName" element={<SearchResults />} />
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
          </Suspense>
        </BrowserRouter>
      )}
    </>
  );
};

export default App;
