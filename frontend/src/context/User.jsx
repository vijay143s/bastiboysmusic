import axios from "axios";
import { createContext, useContext, useEffect, useState } from "react";
import toast, { Toaster } from "react-hot-toast";

const UserContext = createContext();

export const UserProvider = ({ children }) => {
  const [user, setUser] = useState([]);
  const [isAuth, setIsAuth] = useState(false);
  const [btnLoading, setBtnLoading] = useState(false);
  const [loading, setLoading] = useState(true);

  async function registerUser(
    name,
    email,
    password,
    navigate,
    fetchSongs,
    fetchAlbums
  ) {
    setBtnLoading(true);
    try {
      const { data } = await axios.post("/api/user/register", {
        name,
        email,
        password,
      });

      toast.success(data.message);
      setUser(data.user);
      setIsAuth(true);
      setBtnLoading(false);
      navigate("/");
      fetchSongs();
      fetchAlbums();
    } catch (error) {
      toast.error(error.response.data.message);
      setBtnLoading(false);
    }
  }

  async function loginUser(email, password, navigate, fetchSongs, fetchAlbums) {
    setBtnLoading(true);
    try {
      const { data } = await axios.post("/api/user/login", {
        email,
        password,
      });

      toast.success(data.message);
      setUser(data.user);
      setIsAuth(true);
      setBtnLoading(false);
      navigate("/");
      fetchSongs();
      fetchAlbums();
    } catch (error) {
      toast.error(error.response?.data?.message || "Login failed");
      setBtnLoading(false);
    }
  }

  async function fetchUser() {
    try {
      const { data } = await axios.get("/api/user/me");

      setUser(data);
      setIsAuth(true);
      setLoading(false);
    } catch (error) {
      if (process.env.NODE_ENV === 'development') {
        console.error("Error fetching user:", error);
      }
      setIsAuth(false);
      setLoading(false);
    }
  }

  async function logoutUser(navigate) {
    try {
      const { data } = await axios.get("/api/user/logout");
      
      // Clear user state without full page reload
      setUser([]);
      setIsAuth(false);
      toast.success("Logged out successfully");
      
      if (navigate) {
        navigate("/login");
      }
    } catch (error) {
      toast.error(error.response?.data?.message || "Logout failed");
    }
  }

  async function addToPlaylist(id, options = {}) {
    const { silent = true } = options; // Silent by default
    
    // Optimistic update: update UI immediately
    const songIdStr = String(id);
    const isCurrentlyInPlaylist = user.playlist && user.playlist.includes(songIdStr);
    
    // Update user state optimistically
    setUser(prevUser => ({
      ...prevUser,
      playlist: isCurrentlyInPlaylist
        ? prevUser.playlist.filter(sid => sid !== songIdStr)
        : [...(prevUser.playlist || []), songIdStr]
    }));
    
    try {
      const { data } = await axios.post("/api/user/song/" + id);

      // Don't show toast notifications
      
      // Update with server response
      if (data.user) {
        setUser(data.user);
      }
      
      return data;
    } catch (error) {
      // Revert optimistic update on error
      setUser(prevUser => ({
        ...prevUser,
        playlist: isCurrentlyInPlaylist
          ? [...(prevUser.playlist || []), songIdStr]
          : prevUser.playlist.filter(sid => sid !== songIdStr)
      }));
      
      if (!silent && error.response?.data?.message) {
        toast.error(error.response.data.message);
      }
      throw error;
    }
  }

  useEffect(() => {
    fetchUser();
  }, []); // Only run once on mount
  return (
    <UserContext.Provider
      value={{
        registerUser,
        user,
        isAuth,
        btnLoading,
        loading,
        loginUser,
        logoutUser,
        addToPlaylist,
      }}
    >
      {children}
      <Toaster />
    </UserContext.Provider>
  );
};

export const UserData = () => useContext(UserContext);
