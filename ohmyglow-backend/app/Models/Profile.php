<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Profile extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'username,'
    ];

    /**
     * Relasi dengan model User.
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    
    public function getUsernameAttribute()
    {
        return $this->user->username;  // Mengambil username dari relasi user
    }
}
