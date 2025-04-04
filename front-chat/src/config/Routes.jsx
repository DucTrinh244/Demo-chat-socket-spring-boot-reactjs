// import React from "react";
import { Route, Routes } from "react-router";
import App from "../App";
import ChatPage from "../components/ChatPage";
import Login from "../components/Login";
import Register from "../components/Register";
const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/" element={<App />} />
      <Route path="/chat" element={<ChatPage />} />
      <Route path="/about" element={<h1>This is about page</h1>} />
      <Route path="/login" element={<Login/>} />
      <Route path="/register" element={<Register/>} />
      <Route path="*" element={<h1>404 Page Not Found</h1>} />
    </Routes>
  );
};

export default AppRoutes;
