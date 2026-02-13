import { configureStore, createSlice } from '@reduxjs/toolkit';

const ui = createSlice({
  name: 'ui',
  initialState: { darkMode: false },
  reducers: { toggleTheme: (s) => { s.darkMode = !s.darkMode; } }
});

export const { toggleTheme } = ui.actions;
export const store = configureStore({ reducer: { ui: ui.reducer } });
