import { httpClient } from "../config/AxiosHelper";

export const createRoomApi = async (roomDetail) => {
  const respone = await httpClient.post(`/api/rooms`, roomDetail, {
    // gửi request
    headers: {
      "Content-Type": "text/plain",
    },
  });
  return respone.data;
};

export const joinChatApi = async (roomId, userId) => {
  const response = await httpClient.get(
    `/api/rooms/${roomId}?userId=${userId}`
  );
  return response.data;
};

export const getMessagess = async (roomId, size = 50, page = 0) => {
  const response = await httpClient.get(
    `/api/rooms/${roomId}/messages?size=${size}&page=${page}`
  );
  return response.data;
};
