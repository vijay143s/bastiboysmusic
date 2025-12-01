import axios from "axios";
import { createContext, useContext, useEffect, useState } from "react";
import toast, { Toaster } from "react-hot-toast";

// Create an axios instance with credentials for authenticated requests
const authAxios = axios.create({
  withCredentials: true
});

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
      const { data } = await authAxios.post("/api/user/register", {
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
      const { data } = await authAxios.post("/api/user/login", {
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

  async function fetchUser() {
    try {
      const { data } = await authAxios.get("/api/user/me");

      setUser(data);
      setIsAuth(true);
      setLoading(false);
    } catch (error) {
      // Silently handle auth check failures (user not logged in or network issues)
      // This is expected behavior when user is not authenticated
      if (error.code !== 'ERR_NETWORK') {
        console.log('Auth check failed:', error.message);
      }
      setIsAuth(false);
      setLoading(false);
    }
  }

  async function logoutUser() {
    try {
      const { data } = await authAxios.get("/api/user/logout");

      window.location.reload();
    } catch (error) {
      toast.error(error.response.data.message);
    }
  }

  async function addToPlaylist(id, options = {}) {
    const { silent = false } = options;
    try {
      const { data } = await authAxios.post("/api/user/song/" + id);

      if (!silent) toast.success(data.message);
      await fetchUser();
      return data;
    } catch (error) {
      if (!silent && error.response?.data?.message) {
        toast.error(error.response.data.message);
      }
      throw error;
    }
  }

  useEffect(() => {
    fetchUser();
  }, []);
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
