// import React from "react";
import { Route, Routes } from "react-router";
import App from "../App";
import ChatPage from "../components/ChatPage";
import LoginForm from "../components/LoginForm";
import RegisterForm from "../components/RegisterForm";

const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/" element={<App />} />
      <Route path="/chat" element={<ChatPage />} />
      <Route path="/login" element={<LoginForm />} />
      <Route path="/register" element={<RegisterForm />} />
   
      <Route path="*" element={<h1>404 Page Not Found</h1>} />
    </Routes>
  );
};

export default AppRoutes;
