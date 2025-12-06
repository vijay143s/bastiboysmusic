import React, { createContext, useContext, useEffect, useState } from 'react';
import * as SecureStore from 'expo-secure-store';
import Toast from 'react-native-toast-message';
import api from '../services/api';

const UserContext = createContext();

export const UserProvider = ({ children }) => {
    const [user, setUser] = useState(null);
    const [isAuth, setIsAuth] = useState(false);
    const [loading, setLoading] = useState(true);

    // Fetch user profile
    const fetchUser = async () => {
        try {
            const token = await SecureStore.getItemAsync('token');
            if (!token) {
                setLoading(false);
                return;
            }

            const { data } = await api.get('/api/user/me');
            setUser(data.user);
            setIsAuth(true);
        } catch (error) {
            console.error('Error fetching user:', error);
            await SecureStore.deleteItemAsync('token');
            setIsAuth(false);
            setUser(null);
        } finally {
            setLoading(false);
        }
    };

    // Login function
    const loginUser = async (email, password) => {
        try {
            const { data } = await api.post('/api/user/login', { email, password });

            await SecureStore.setItemAsync('token', data.token);
            setUser(data.user);
            setIsAuth(true);

            Toast.show({
                type: 'success',
                text1: 'Login Successful',
                text2: `Welcome back, ${data.user.name}!`,
            });

            return { success: true };
        } catch (error) {
            const message = error.response?.data?.message || 'Login failed';
            Toast.show({
                type: 'error',
                text1: 'Login Failed',
                text2: message,
            });
            return { success: false, error: message };
        }
    };

    // Register function
    const registerUser = async (name, email, password) => {
        try {
            const { data } = await api.post('/api/user/register', { name, email, password });

            await SecureStore.setItemAsync('token', data.token);
            setUser(data.user);
            setIsAuth(true);

            Toast.show({
                type: 'success',
                text1: 'Registration Successful',
                text2: `Welcome, ${data.user.name}!`,
            });

            return { success: true };
        } catch (error) {
            const message = error.response?.data?.message || 'Registration failed';
            Toast.show({
                type: 'error',
                text1: 'Registration Failed',
                text2: message,
            });
            return { success: false, error: message };
        }
    };

    // Logout function
    const logoutUser = async () => {
        try {
            await SecureStore.deleteItemAsync('token');
            setUser(null);
            setIsAuth(false);

            Toast.show({
                type: 'success',
                text1: 'Logged Out',
                text2: 'See you soon!',
            });
        } catch (error) {
            console.error('Error logging out:', error);
        }
    };

    // Check auth on mount
    useEffect(() => {
        fetchUser();
    }, []);

    return (
        <UserContext.Provider
            value={{
                user,
                isAuth,
                loading,
                loginUser,
                registerUser,
                logoutUser,
                fetchUser,
            }}
        >
            {children}
        </UserContext.Provider>
    );
};

export const UserData = () => useContext(UserContext);
