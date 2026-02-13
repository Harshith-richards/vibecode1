import { useState } from 'react';
import { api } from '../../lib/api';

export const LoginPage = () => {
  const [email, setEmail] = useState('admin@globalbim.com');
  const [password, setPassword] = useState('Admin123!');

  return (
    <div className="p-8 max-w-md mx-auto">
      <h1 className="text-2xl font-bold mb-4">Login</h1>
      <input className="border p-2 w-full mb-3" value={email} onChange={(e) => setEmail(e.target.value)} />
      <input className="border p-2 w-full mb-3" type="password" value={password} onChange={(e) => setPassword(e.target.value)} />
      <button className="bg-blue-600 text-white px-4 py-2" onClick={() => api.post('/api/auth/login', { email, password })}>Sign in</button>
    </div>
  );
};
